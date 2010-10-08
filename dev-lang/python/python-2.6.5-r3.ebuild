# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.6.5-r3.ebuild,v 1.8 2010/08/11 22:32:00 josejx Exp $

EAPI="2"

inherit autotools eutils flag-o-matic multilib pax-utils python toolchain-funcs

MY_P="Python-${PV}"

PATCHSET_REVISION="5"

DESCRIPTION="Python is an interpreted, interactive, object-oriented programming language."
HOMEPAGE="http://www.python.org/"
SRC_URI="http://www.python.org/ftp/python/${PV}/${MY_P}.tar.bz2
	mirror://gentoo/python-gentoo-patches-${PV}$([[ "${PATCHSET_REVISION}" != "0" ]] && echo "-r${PATCHSET_REVISION}").tar.bz2"

LICENSE="PSF-2.2"
SLOT="2.6"
PYTHON_ABI="${SLOT}"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="-berkdb build doc elibc_uclibc examples gdbm hardened ipv6 +ncurses +readline sqlite +ssl +threads tk +wide-unicode wininst +xml"

RDEPEND=">=app-admin/eselect-python-20091230
		>=sys-libs/zlib-1.1.3
		virtual/libffi
		virtual/libintl
		!build? (
			berkdb? ( || (
				sys-libs/db:4.7
				sys-libs/db:4.6
				sys-libs/db:4.5
				sys-libs/db:4.4
				sys-libs/db:4.3
				sys-libs/db:4.2
			) )
			gdbm? ( sys-libs/gdbm )
			ncurses? (
				>=sys-libs/ncurses-5.2
				readline? ( >=sys-libs/readline-4.1 )
			)
			sqlite? ( >=dev-db/sqlite-3 )
			ssl? ( dev-libs/openssl )
			tk? ( >=dev-lang/tk-8.0 )
			xml? ( >=dev-libs/expat-2 )
		)
		doc? ( dev-python/python-docs:${SLOT} )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		!sys-devel/gcc[libffi]"
RDEPEND+=" !build? ( app-misc/mime-types )"
PDEPEND="app-admin/python-updater"

PROVIDE="virtual/python"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_pkg_setup

	if use berkdb; then
		ewarn "\"bsddb\" module is out-of-date and no longer maintained inside dev-lang/python. It has"
		ewarn "been additionally removed in Python 3. You should use external, still maintained \"bsddb3\""
		ewarn "module provided by dev-python/bsddb3 which supports both Python 2 and Python 3."
	fi
}

src_prepare() {
	# Ensure that internal copies of expat, libffi and zlib are not used.
	rm -fr Modules/expat
	rm -fr Modules/_ctypes/libffi*
	rm -fr Modules/zlib

	if ! tc-is-cross-compiler; then
		rm "${WORKDIR}/${PV}"/*_all_crosscompile.patch
	fi

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/${PV}"

	# Avoid regeneration, which would not change contents of files.
	touch Include/Python-ast.h Python/Python-ast.c

	sed -i -e "s:@@GENTOO_LIBDIR@@:$(get_libdir):g" \
		Lib/distutils/command/install.py \
		Lib/distutils/sysconfig.py \
		Lib/site.py \
		Makefile.pre.in \
		Modules/Setup.dist \
		Modules/getpath.c \
		setup.py || die "sed failed to replace @@GENTOO_LIBDIR@@"

	# Fix os.utime() on hppa. utimes it not supported but unfortunately reported as working - gmsoft (22 May 04)
	# PLEASE LEAVE THIS FIX FOR NEXT VERSIONS AS IT'S A CRITICAL FIX !!!
	[[ "${ARCH}" == "hppa" ]] && sed -e "s/utimes //" -i "${S}/configure"

	if ! use wininst; then
		# Remove Microsoft Windows executables.
		rm Lib/distutils/command/wininst-*.exe
	fi

	#gentoo bug #329499
	use hardened && epatch "${FILESDIR}"/paxteam-${PV}.patch

	# Fix OtherFileTests.testStdin() not to assume
	# that stdin is a tty for bug #248081.
	sed -e "s:'osf1V5':'osf1V5' and sys.stdin.isatty():" -i Lib/test/test_file.py || die "sed failed"

	eautoreconf
}

src_configure() {
	# Disable extraneous modules with extra dependencies.
	if use build; then
		export PYTHON_DISABLE_MODULES="dbm _bsddb gdbm _curses _curses_panel readline _sqlite3 _tkinter _elementtree pyexpat"
		export PYTHON_DISABLE_SSL="1"
	else
		# dbm module can be linked against berkdb or gdbm.
		# Defaults to gdbm when both are enabled, #204343.
		local disable
		use berkdb   || use gdbm || disable+=" dbm"
		use berkdb   || disable+=" _bsddb"
		use gdbm     || disable+=" gdbm"
		use ncurses  || disable+=" _curses _curses_panel"
		use readline || disable+=" readline"
		use sqlite   || disable+=" _sqlite3"
		use ssl      || export PYTHON_DISABLE_SSL="1"
		use tk       || disable+=" _tkinter"
		use xml      || disable+=" _elementtree pyexpat" # _elementtree uses pyexpat.
		export PYTHON_DISABLE_MODULES="${disable}"

		if ! use xml; then
			ewarn "You have configured Python without XML support."
			ewarn "This is NOT a recommended configuration as you"
			ewarn "may face problems parsing any XML documents."
		fi
	fi

	if [[ -n "${PYTHON_DISABLE_MODULES}" ]]; then
		einfo "Disabled modules: ${PYTHON_DISABLE_MODULES}"
	fi

	if [[ "$(gcc-major-version)" -ge 4 ]]; then
		append-flags -fwrapv
	fi

	filter-flags -malign-double

	[[ "${ARCH}" == "alpha" ]] && append-flags -fPIC

	# https://bugs.gentoo.org/show_bug.cgi?id=50309
	if is-flagq -O3; then
		is-flagq -fstack-protector-all && replace-flags -O3 -O2
		use hardened && replace-flags -O3 -O2
	fi

	if tc-is-cross-compiler; then
		OPT="-O1" CFLAGS="" LDFLAGS="" CC="" \
		./configure --{build,host}=${CBUILD} || die "cross-configure failed"
		emake python Parser/pgen || die "cross-make failed"
		mv python hostpython
		mv Parser/pgen Parser/hostpgen
		make distclean
		sed -i \
			-e "/^HOSTPYTHON/s:=.*:=./hostpython:" \
			-e "/^HOSTPGEN/s:=.*:=./Parser/hostpgen:" \
			Makefile.pre.in || die "sed failed"
	fi

	# Export CXX so it ends up in /usr/lib/python2.X/config/Makefile.
	tc-export CXX

	# Set LDFLAGS so we link modules with -lpython2.6 correctly.
	# Needed on FreeBSD unless Python 2.6 is already installed.
	# Please query BSD team before removing this!
	append-ldflags "-L."

	OPT="" econf \
		--with-fpectl \
		--enable-shared \
		$(use_enable ipv6) \
		$(use_with threads) \
		$(use wide-unicode && echo "--enable-unicode=ucs4" || echo "--enable-unicode=ucs2") \
		--infodir='${prefix}/share/info' \
		--mandir='${prefix}/share/man' \
		--with-libc="" \
		--with-system-ffi
}

src_test() {
	# Tests will not work when cross compiling.
	if tc-is-cross-compiler; then
		elog "Disabling tests due to crosscompiling."
		return
	fi

	# Byte compiling should be enabled here.
	# Otherwise test_import fails.
	python_enable_pyc

	# Skip failing tests.
	local skip_tests="distutils httpservers minidom pyexpat sax tcl"

	# test_ctypes fails with PAX kernel (bug #234498).
	host-is-pax && skip_tests+=" ctypes"

	for test in ${skip_tests}; do
		mv "${S}/Lib/test/test_${test}.py" "${T}"
	done

	# Rerun failed tests in verbose mode (regrtest -w).
	EXTRATESTOPTS="-w" emake test
	local result="$?"

	for test in ${skip_tests}; do
		mv "${T}/test_${test}.py" "${S}/Lib/test/test_${test}.py"
	done

	elog "The following tests have been skipped:"
	for test in ${skip_tests}; do
		elog "test_${test}.py"
	done

	elog "If you would like to run them, you may:"
	elog "cd '${EPREFIX}$(python_get_libdir)/test'"
	elog "and run the tests separately."

	python_disable_pyc

	if [[ "${result}" -ne 0 ]]; then
		die "emake test failed"
	fi
}

src_install() {
	[[ -z "${ED}" ]] && ED="${D%/}${EPREFIX}/"

	emake DESTDIR="${D}" altinstall maninstall || die "emake altinstall maninstall failed"
	python_clean_installation_image -q

	mv "${ED}usr/bin/python${SLOT}-config" "${ED}usr/bin/python-config-${SLOT}"

	# Fix collisions between different slots of Python.
	mv "${ED}usr/bin/2to3" "${ED}usr/bin/2to3-${SLOT}"
	mv "${ED}usr/bin/pydoc" "${ED}usr/bin/pydoc${SLOT}"
	mv "${ED}usr/bin/idle" "${ED}usr/bin/idle${SLOT}"
	mv "${ED}usr/share/man/man1/python.1" "${ED}usr/share/man/man1/python${SLOT}.1"
	rm -f "${ED}usr/bin/smtpd.py"

	if use build; then
		rm -fr "${ED}usr/bin/idle${SLOT}" "${ED}$(python_get_libdir)/"{bsddb,idlelib,lib-tk,sqlite3,test}
	else
		use elibc_uclibc && rm -fr "${ED}$(python_get_libdir)/"{bsddb/test,test}
		use berkdb || rm -fr "${ED}$(python_get_libdir)/"{bsddb,test/test_bsddb*}
		use sqlite || rm -fr "${ED}$(python_get_libdir)/"{sqlite3,test/test_sqlite*}
		use tk || rm -fr "${ED}usr/bin/idle${SLOT}" "${ED}$(python_get_libdir)/"{idlelib,lib-tk}
	fi

	use threads || rm -fr "${ED}$(python_get_libdir)/multiprocessing"

	prep_ml_includes $(python_get_includedir)

	dodoc Misc/{ACKS,HISTORY,NEWS} || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${S}/Tools" || die "doins failed"
	fi

	newinitd "${FILESDIR}/pydoc.init" pydoc-${SLOT} || die "newinitd failed"
	newconfd "${FILESDIR}/pydoc.conf" pydoc-${SLOT} || die "newconfd failed"

	# Do not install empty directory.
	rmdir "${ED}$(python_get_libdir)/lib-old"
}

pkg_preinst() {
	if has_version "<${CATEGORY}/${PN}-${SLOT}" && ! has_version "${CATEGORY}/${PN}:2.6" && ! has_version "${CATEGORY}/${PN}:2.7"; then
		python_updater_warning="1"
	fi
}

eselect_python_update() {
	local eselect_python_options
	[[ "$(eselect python show)" == "python2."* ]] && eselect_python_options="--python2"

	# Create python2 symlink.
	eselect python update --python2 > /dev/null

	eselect python update ${eselect_python_options}
}

pkg_postinst() {
	eselect_python_update

	python_mod_optimize -f -x "/(site-packages|test|tests)/" $(python_get_libdir)

	if [[ "${python_updater_warning}" == "1" ]]; then
		ewarn
		ewarn "\e[1;31m************************************************************************\e[0m"
		ewarn
		ewarn "You have just upgraded from an older version of Python."
		ewarn "You should run 'python-updater \${options}' to rebuild Python modules."
		ewarn
		ewarn "\e[1;31m************************************************************************\e[0m"
		ewarn
		ebeep 12
	fi
}

pkg_postrm() {
	eselect_python_update

	python_mod_cleanup $(python_get_libdir)
}
