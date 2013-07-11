# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/portage/portage-2.1.12.2.ebuild,v 1.14 2013/07/01 02:24:59 zmedico Exp $

# Require EAPI 2 since we now require at least python-2.6 (for python 3
# syntax support) which also requires EAPI 2.
EAPI=2
PYTHON_COMPAT=(
	pypy1_9 pypy2_0
	python3_1 python3_2 python3_3 python3_4
	python2_6 python2_7
)
inherit eutils multilib

DESCRIPTION="Portage is the package management and distribution system for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/index.xml"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
SLOT="0"
IUSE="build doc epydoc +ipc linguas_pl linguas_ru pypy2_0 pentoo python2 python3 stupid_patches selinux xattr"

for _pyimpl in ${PYTHON_COMPAT[@]} ; do
	IUSE+=" python_targets_${_pyimpl}"
done
unset _pyimpl

# Import of the io module in python-2.6 raises ImportError for the
# thread module if threading is disabled.
python_dep_ssl="python3? ( =dev-lang/python-3*[ssl] )
	!pypy2_0? ( !python2? ( !python3? (
		|| ( >=dev-lang/python-2.7[ssl] dev-lang/python:2.6[threads,ssl] )
	) ) )
	pypy2_0? ( !python2? ( !python3? ( dev-python/pypy:2.0[bzip2,ssl] ) ) )
	python2? ( !python3? ( || ( dev-lang/python:2.7[ssl] dev-lang/python:2.6[ssl,threads] ) ) )"
python_dep="${python_dep_ssl//\[ssl\]}"
python_dep="${python_dep//,ssl}"
python_dep="${python_dep//ssl,}"

python_dep="${python_dep}
	python_targets_pypy1_9? ( dev-python/pypy:1.9 )
	python_targets_pypy2_0? ( dev-python/pypy:2.0 )
	python_targets_python2_6? ( dev-lang/python:2.6 )
	python_targets_python2_7? ( dev-lang/python:2.7 )
	python_targets_python3_1? ( dev-lang/python:3.1 )
	python_targets_python3_2? ( dev-lang/python:3.2 )
	python_targets_python3_3? ( dev-lang/python:3.3 )
	python_targets_python3_4? ( dev-lang/python:3.4 )
"

# The pysqlite blocker is for bug #282760.
# make-3.82 is for bug #455858
DEPEND="${python_dep}
	>=sys-devel/make-3.82
	>=sys-apps/sed-4.0.5 sys-devel/patch
	doc? ( app-text/xmlto ~app-text/docbook-xml-dtd-4.4 )
	epydoc? ( >=dev-python/epydoc-2.0 !<=dev-python/pysqlite-2.4.1 )"
# Require sandbox-2.2 for bug #288863.
# For xattr, we can spawn getfattr and setfattr from sys-apps/attr, but that's
# quite slow, so it's not considered in the dependencies as an alternative to
# to python-3.3 / pyxattr. Also, xattr support is only tested with Linux, so
# for now, don't pull in xattr deps for other kernels.
# For whirlpool hash, require python[ssl] or python-mhash (bug #425046).
# For compgen, require bash[readline] (bug #445576).
RDEPEND="${python_dep}
	!build? ( >=sys-apps/sed-4.0.5
		|| ( >=app-shells/bash-4.2_p37[readline] ( <app-shells/bash-4.2_p37 >=app-shells/bash-3.2_p17 ) )
		>=app-admin/eselect-1.2
		|| ( ${python_dep_ssl} dev-python/python-mhash )
	)
	elibc_FreeBSD? ( sys-freebsd/freebsd-bin )
	elibc_glibc? ( >=sys-apps/sandbox-2.2 )
	elibc_uclibc? ( >=sys-apps/sandbox-2.2 )
	>=app-misc/pax-utils-0.1.17
	xattr? ( kernel_linux? ( || ( >=dev-lang/python-3.3_pre20110902 dev-python/pyxattr ) ) )
	selinux? ( || ( >=sys-libs/libselinux-2.0.94[python] <sys-libs/libselinux-2.0.94 ) )
	!<app-shells/bash-3.2_p17
	!<app-admin/logrotate-3.8.0"
PDEPEND="
	!build? (
		>=net-misc/rsync-2.6.4
		userland_GNU? ( >=sys-apps/coreutils-6.4 )
	)"
# coreutils-6.4 rdep is for date format in emerge-webrsync #164532
# NOTE: FEATURES=installsources requires debugedit and rsync

SRC_ARCHIVES="http://dev.gentoo.org/~zmedico/portage/archives"

prefix_src_archives() {
	local x y
	for x in ${@}; do
		for y in ${SRC_ARCHIVES}; do
			echo ${y}/${x}
		done
	done
}

PV_PL="2.1.2"
PATCHVER_PL=""
TARBALL_PV=$PV
SRC_URI="mirror://gentoo/${PN}-${TARBALL_PV}.tar.bz2
	$(prefix_src_archives ${PN}-${TARBALL_PV}.tar.bz2)
	linguas_pl? ( mirror://gentoo/${PN}-man-pl-${PV_PL}.tar.bz2
		$(prefix_src_archives ${PN}-man-pl-${PV_PL}.tar.bz2) )"

PATCHVER=
[[ $TARBALL_PV = $PV ]] || PATCHVER=$PV
if [ -n "${PATCHVER}" ]; then
	SRC_URI="${SRC_URI} mirror://gentoo/${PN}-${PATCHVER}.patch.bz2
	$(prefix_src_archives ${PN}-${PATCHVER}.patch.bz2)"
fi

S="${WORKDIR}"/${PN}-${TARBALL_PV}
S_PL="${WORKDIR}"/${PN}-${PV_PL}

compatible_python_is_selected() {
	[[ $(/usr/bin/python -c 'import sys ; sys.stdout.write(sys.hexversion >= 0x2060000 and "good" or "bad")') = good ]]
}

current_python_has_xattr() {
	[[ ${EPYTHON} ]] || die 'No Python implementation set (EPYTHON is null).'
	local PYTHON=/usr/bin/${EPYTHON}
	[[ $("${PYTHON}" -c 'import sys ; sys.stdout.write(sys.hexversion >= 0x3030000 and "yes" or "no")') = yes ]] || \
	"${PYTHON}" -c 'import xattr' 2>/dev/null
}

call_with_python_impl() {
	[[ ${EPYTHON} ]] || die 'No Python implementation set (EPYTHON is null).'
	env EPYTHON=${EPYTHON} "$@"
}

get_python_interpreter() {
	[ $# -eq 1 ] || die "expected 1 argument, got $#: $*"
	local impl=$1 python
	case "${impl}" in
		python*)
			python=${impl/_/.}
			;;
		pypy*)
			python=${impl/_/.}
			python=${python/pypy/pypy-c}
			;;
		*)
			die "Unrecognized python target: ${impl}"
	esac
	echo ${python}
}

get_python_sitedir() {
	[ $# -eq 1 ] || die "expected 1 argument, got $#: $*"
	local impl=$1
	local site_dir=/usr/$(get_libdir)/${impl/_/.}/site-packages
	[[ -d ${ROOT}${site_dir} ]] || \
		ewarn "site-packages dir missing for ${impl}: ${ROOT}${site_dir}"
	echo "${site_dir}"
}

python_compileall() {
	[[ ${EPYTHON} ]] || die 'No Python implementation set (EPYTHON is null).'
	local d=$1 PYTHON=/usr/bin/${EPYTHON}
	local d_image=${D}${d#/}
	[[ -d ${d_image} ]] || die "directory does not exist: ${d_image}"
	case "${EPYTHON}" in
		python*)
			"${PYTHON}" -m compileall -q -f -d "${d}" "${d_image}" || die
			# Note: Using -OO breaks emaint, since it requires __doc__,
			# and __doc__ is None when -OO is used.
			"${PYTHON}" -O -m compileall -q -f -d "${d}" "${d_image}" || die
			;;
		pypy*)
			"${PYTHON}" -m compileall -q -f -d "${d}" "${d_image}" || die
			;;
		*)
			die "Unrecognized EPYTHON value: ${EPYTHON}"
	esac
}

pkg_setup() {
	if use python2 && use python3 ; then
		ewarn "Both python2 and python3 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python3."
	fi
	if use pypy2_0 && use python3 ; then
		ewarn "Both pypy2_0 and python3 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python3."
	fi
	if use pypy2_0 && use python2 ; then
		ewarn "Both pypy2_0 and python2 USE flags are enabled, but only one"
		ewarn "can be in the shebangs. Using python2"
	fi
	if ! use pypy2_0 && ! use python2 && ! use python3 && \
		! compatible_python_is_selected ; then
		ewarn "Attempting to select a compatible default python interpreter"
		local x success=0
		for x in /usr/bin/python2.* ; do
			x=${x#/usr/bin/python2.}
			if [[ $x -ge 6 ]] 2>/dev/null ; then
				eselect python set python2.$x
				if compatible_python_is_selected ; then
					elog "Default python interpreter is now set to python-2.$x"
					success=1
					break
				fi
			fi
		done
		if [ $success != 1 ] ; then
			eerror "Unable to select a compatible default python interpreter!"
			die "This version of portage requires at least python-2.6 to be selected as the default python interpreter (see \`eselect python --help\`)."
		fi
	fi

	# We use EPYTHON to designate the active python interpreter,
	# but we only export when needed, via call_with_python_impl.
	EPYTHON=python
	export -n EPYTHON
	if use python3; then
		EPYTHON=python3
	elif use python2; then
		EPYTHON=python2
	elif use pypy2_0; then
		EPYTHON=pypy-c2.0
	fi
}

src_prepare() {
	if [ -n "${PATCHVER}" ] ; then
		if [[ -L $S/bin/ebuild-helpers/portageq ]] ; then
			rm "$S/bin/ebuild-helpers/portageq" \
				|| die "failed to remove portageq helper symlink"
		fi
		epatch "${WORKDIR}/${PN}-${PATCHVER}.patch"
	fi
	einfo "Setting portage.VERSION to ${PVR} ..."
	sed -e "s/^VERSION=.*/VERSION=\"${PVR}\"/" -i pym/portage/__init__.py || \
		die "Failed to patch portage.VERSION"
	sed -e "1s/VERSION/${PVR}/" -i doc/fragment/version || \
		die "Failed to patch VERSION in doc/fragment/version"
	sed -e "1s/VERSION/${PVR}/" -i $(find man -type f) || \
		die "Failed to patch VERSION in man page headers"

	if ! use ipc ; then
		einfo "Disabling ipc..."
		sed -e "s:_enable_ipc_daemon = True:_enable_ipc_daemon = False:" \
			-i pym/_emerge/AbstractEbuildProcess.py || \
			die "failed to patch AbstractEbuildProcess.py"
	fi

	if use xattr && use kernel_linux ; then
		einfo "Adding FEATURES=xattr to make.globals ..."
		echo -e '\nFEATURES="${FEATURES} xattr"' >> cnf/make.globals \
			|| die "failed to append to make.globals"
	fi

	local set_shebang=
	if use python3; then
		set_shebang=python3
	elif use python2; then
		set_shebang=python2
	elif use pypy2_0; then
		set_shebang=pypy-c2.0
	fi
	if [[ -n ${set_shebang} ]] ; then
		einfo "Converting shebangs for ${set_shebang}..."
		while read -r -d $'\0' ; do
			local shebang=$(head -n1 "$REPLY")
			if [[ ${shebang} == "#!/usr/bin/python"* ]] ; then
				sed -i -e "1s:python:${set_shebang}:" "$REPLY" || \
					die "sed failed"
			fi
		done < <(find . -type f -print0)
	fi

	cd "${S}/cnf" || die
	if [ -f "make.conf.${ARCH}".diff ]; then
		patch make.conf "make.conf.${ARCH}".diff || \
			die "Failed to patch make.conf.example"
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
	fi
}

src_compile() {
	if use doc; then
		call_with_python_impl \
		emake docbook || die
	fi

	if use epydoc; then
		einfo "Generating api docs"
		call_with_python_impl \
		emake epydoc || die
	fi
}

src_test() {
	call_with_python_impl \
	emake test || die
}

src_install() {
	if use pentoo; then
		if use stupid_patches; then
			epatch "${FILESDIR}/no_fs_lock.patch"
			epatch "${FILESDIR}/parallel_install_system.patch"
		fi
	fi
	call_with_python_impl \
	emake DESTDIR="${D}" \
		sysconfdir="/etc" \
		prefix="/usr" \
		install || die

	# Extended set config is currently disabled in portage-2.1.x.
	rm -rf "${D}/usr/share/portage/config/sets" || die

	# Use dodoc for compression, since the Makefile doesn't do that.
	dodoc "${S}"/{ChangeLog,NEWS,RELEASE-NOTES} || die

	if use linguas_pl; then
		doman -i18n=pl "${S_PL}"/man/pl/*.[0-9] || die
		doman -i18n=pl_PL.UTF-8 "${S_PL}"/man/pl_PL.UTF-8/*.[0-9] || die
	fi

	# Allow external portage API consumers to import portage python modules
	# (this used to be done with PYTHONPATH setting in /etc/env.d).
	# For each of PYTHON_TARGETS, install a tree of *.py symlinks in
	# site-packages, and compile with the corresponding interpreter.
	local impl files mod_dir dest_mod_dir python relative_path x
	for impl in "${PYTHON_COMPAT[@]}" ; do
		use "python_targets_${impl}" || continue
		if use build && [[ ${ROOT} == / &&
			! -x /usr/bin/$(get_python_interpreter ${impl}) ]] ; then
			# Tolerate --nodeps at beginning of stage1 for catalyst
			ewarn "skipping python_targets_${impl}, interpreter not found"
			continue
		fi
		while read -r mod_dir ; do
			cd "${D}/usr/lib/portage/pym/${mod_dir}" || die
			files=$(echo *.py)
			if [ -z "${files}" ] || [ "${files}" = "*.py" ]; then
				# __pycache__ directories contain no py files
				continue
			fi
			dest_mod_dir=$(get_python_sitedir ${impl})/${mod_dir}
			dodir "${dest_mod_dir}" || die
			relative_path=../../../lib/portage/pym/${mod_dir}
			x=/${mod_dir}
			while [ -n "${x}" ] ; do
				relative_path=../${relative_path}
				x=${x%/*}
			done
			for x in ${files} ; do
				dosym "${relative_path}/${x}" \
					"${dest_mod_dir}/${x}" || die
			done
		done < <(cd "${D}"/usr/lib/portage/pym || die ; find * -type d ! -path "portage/tests*")
		cd "${S}" || die
		EPYTHON=$(get_python_interpreter ${impl}) \
		python_compileall "$(get_python_sitedir ${impl})"
	done

	# Compile /usr/lib/portage/pym with the active interpreter, since portage
	# internal commands force this directory to the beginning of sys.path.
	python_compileall /usr/lib/portage/pym
}

pkg_preinst() {
	if [[ $ROOT == / ]] ; then
		# Run some minimal tests as a sanity check.
		local test_runner=$(find "$D" -name runTests)
		if [[ -n $test_runner && -x $test_runner ]] ; then
			einfo "Running preinst sanity tests..."
			"$test_runner" || die "preinst sanity tests failed"
		fi
	fi

	if use xattr && ! current_python_has_xattr ; then
		ewarn "For optimal performance in xattr handling, install"
		ewarn "dev-python/pyxattr, or install >=dev-lang/python-3.3 and"
		ewarn "enable USE=python3 for $CATEGORY/$PN."
	fi

	# elog dir must exist to avoid logrotate error for bug #415911.
	# This code runs in preinst in order to bypass the mapping of
	# portage:portage to root:root which happens after src_install.
	keepdir /var/log/portage/elog
	# This is allowed to fail if the user/group are invalid for prefix users.
	if chown portage:portage "${D}"var/log/portage{,/elog} 2>/dev/null ; then
		chmod g+s,ug+rwx "${D}"var/log/portage{,/elog}
	fi

	if [[ -d ${ROOT}var/log/portage && \
		$(ls -ld "${ROOT}var/log/portage") != *" portage portage "* ]] && \
		has_version '<sys-apps/portage-2.1.10.11' ; then
		# Initialize permissions for bug #378451 and bug #377177, since older
		# portage does not create /var/log/portage with the desired default
		# permissions.
		einfo "Applying portage group permission to ${ROOT}var/log/portage for bug #378451"
		chown portage:portage "${ROOT}var/log/portage"
		chmod g+ws "${ROOT}var/log/portage"
	fi

	if has_version '<sys-apps/portage-2.1.10.61' ; then
		ewarn "FEATURES=config-protect-if-modified is now enabled by default."
		ewarn "This causes the CONFIG_PROTECT behavior to be skipped for"
		ewarn "files that have not been modified since they were installed."
	fi

	# If portage-2.1.6 is installed and the preserved_libs_registry exists,
	# assume that the NEEDED.ELF.2 files have already been generated.
	has_version "<=${CATEGORY}/${PN}-2.2_pre7" && \
		! { [ -e "${ROOT}"var/lib/portage/preserved_libs_registry ] && \
		has_version ">=${CATEGORY}/${PN}-2.1.6_rc" ; } \
		&& NEEDED_REBUILD_UPGRADE=true || NEEDED_REBUILD_UPGRADE=false
}

pkg_postinst() {
	if ${NEEDED_REBUILD_UPGRADE} ; then
		einfo "rebuilding NEEDED.ELF.2 files"
		local cpv filename line newline
		for cpv in "${ROOT}/var/db/pkg"/*/*; do
			[[ -f "${cpv}/NEEDED" && ! -f "${cpv}/NEEDED.ELF.2" ]] || continue
			while read -r line; do
				filename=${line% *}
				newline=$(scanelf -BF "%a;%F;%S;%r;%n" "${ROOT%/}${filename}")
				newline=${newline//  -  }
				[[ ${#ROOT} -gt 1 ]] && newline=${newline/${ROOT%/}}
				echo "${newline:3}" >> "${cpv}/NEEDED.ELF.2"
			done < "${cpv}/NEEDED"
		done
	fi
}
