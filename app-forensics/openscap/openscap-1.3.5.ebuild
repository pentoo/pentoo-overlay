# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit cmake python-single-r1

DESCRIPTION="Framework which enables integration with Security Content Automation Protocol"
HOMEPAGE="https://www.open-scap.org/"
SRC_URI="https://github.com/OpenSCAP/openscap/releases/download/${PV}/${P}.tar.gz"

KEYWORDS="~amd64" # app-emulation/podman — is not support '~x86' keyword
LICENSE="LGPL-2.1+"
SLOT="0"

IUSE="acl caps chroot doc docker gconf ldap nss dbus pcre perl podman python rpm selinux sce ssh sql test vm xattr"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	test? ( perl python )
	docker? ( python )"

RDEPEND="
	app-arch/bzip2
	acl? ( virtual/acl )
	dbus? ( sys-apps/dbus )
	caps? ( sys-libs/libcap )
	dev-libs/libxslt
	dev-libs/libxml2:2=
	dev-libs/popt
	gconf? ( gnome-base/gconf )
	ldap? ( net-nds/openldap )
	net-misc/curl
	nss? ( dev-libs/nss )
	!nss? ( dev-libs/libgcrypt:0 )
	pcre? ( dev-libs/libpcre:3=[unicode] )
	podman? ( app-emulation/podman )
	perl? (
		dev-lang/perl
		dev-perl/XML-Parser
		dev-perl/XML-XPath
	)
	python? ( ${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/docker-py[${PYTHON_MULTI_USEDEP}]
			docker? ( dev-python/requests[${PYTHON_MULTI_USEDEP}] )
		')
	)
	rpm? ( app-arch/rpm )
	selinux? ( sys-libs/libselinux )
	ssh? ( virtual/ssh )
	sql? ( dev-db/opendbx )
	sys-process/procps
	xattr? ( sys-apps/attr )"

DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		app-text/asciidoc
	)
	test? ( net-misc/ipcalc )"

BDEPEND="python? ( dev-lang/swig )"

pkg_setup() {
	#if use python; then
		python-single-r1_pkg_setup
	#fi
}

src_prepare() {
	if use test; then
		# modify/disable not gentoo specific tests
		sed -i 's,.*test_run ,#&,' tests/API/XCCDF/default_cpe/test_default_cpe.sh || die
		sed -i 's,.*assert_exists ,#&,' tests/API/XCCDF/unittests/test_deriving_xccdf_result_from_oval.sh || die
		sed -i '/\[ $ret -eq 2 \]/d;s,.*assert_exists ,#&,' tests/API/XCCDF/unittests/test_remediate_unresolved.sh || die
		sed -i 's/uname -p/uname -m/' tests/probes/uname/test_probes_uname.xml.sh || die
		#sed -i 's,.*test_run ,#&,' tests/probes/rpminfo/test_probes_rpminfo.xml.sh || die
		#sed -i 's,.*test_run ,#&,' tests/probes/rpmverify/all.sh || die
		#sed -i 's,.*test_run ,#&,' tests/probes/rpmverifyfile/all.sh || die
		#sed -i 's,.*test_run ,#&,' tests/probes/rpmverifypackage/test_probes_rpmverifypackage.sh || die
		sed -i 's,.*test_run ,#&,' tests/probes/sysctl/all.sh || die

		# update paths for valgrind
		#sed -i "s:valgrind_output=/tmp/valgrind_\$$.log:valgrind_output=${T}/valgrind_\$$.log:" tests/valgrind_test.sh || die
		#sed -i 's:oscap_program=$actualdir/utils/.libs/oscap:oscap_program=$actualdir/utils/oscap:' tests/valgrind_test.sh || die

		# https://github.com/OpenSCAP/openscap/blob/52be17e064df72d8453c7b484bd6224f3f3263b6/src/OVAL/probes/SEAP/seap-packet.c#L845
		:
	fi

	python_fix_shebang -q "${S}"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_SCE="$(usex sce)"
		-DENABLE_PERL="$(usex perl)"
		-DENABLE_PYTHON3="$(usex python)"
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DENABLE_DOCS="$(usex doc)"
		-DCMAKE_INSTALL_DOCDIR="/usr/share/doc/${PF}"

		-DENABLE_OSCAP_UTIL="ON"
		-DENABLE_OSCAP_UTIL_AS_RPM="$(usex rpm)" # scap-as-rpm — is a py3 script
		-DENABLE_OSCAP_UTIL_PODMAN="$(usex podman)"
		-DENABLE_OSCAP_UTIL_SSH="$(usex ssh)"
		-DENABLE_OSCAP_UTIL_CHROOT="$(usex chroot)"
		-DENABLE_OSCAP_UTIL_VM="$(usex vm)" # req: ENABLE_OSCAP_UTIL=yes
		-DENABLE_OSCAP_UTIL_DOCKER="$(usex docker)" # req: python flag (python bindings)

		-DENABLE_TESTS="$(usex test)"
		-DENABLE_MITRE="OFF" # mitre testing requires specific environment support — fuck it
		-DENABLE_VALGRIND="OFF" # fuck it because it's not completely with sandbox too
	)

	# upstream wants to building it only in ${S}/build directory
	# do not remove it without testing.
	#
	# see more:
	# * https://github.com/OpenSCAP/openscap/blob/2c04d939b93b7394f76adb86bf0b24ff0d76d963/CMakeLists.txt#L50-L54
	BUILD_DIR="${S}/build"

	cmake_src_configure
}

src_install() {
	cmake_src_install
	use python && python_optimize "${D}$(python_get_sitedir)"
}
