# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
CMAKE_IN_SOURCE_BUILD=1

inherit distutils-r1 cmake-utils linux-info

DESCRIPTION="Library for carrying out memory forensics using firewire/ieee1394"
HOMEPAGE="https://freddie.witherden.org/tools/libforensic1394/ https://github.com/FreddieWitherden/libforensic1394"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FreddieWitherden/libforensic1394"
else
	SRC_URI="https://github.com/FreddieWitherden/libforensic1394/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"

IUSE="+python static-libs"
RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="python? ( ${PYTHON_DEPS} )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_setup() {
	CONFIG_CHECK="~FIREWIRE_OHCI"
	linux-info_pkg_setup
}

src_prepare() {
	if use python; then
		pushd python >/dev/null || die
		distutils-r1_src_prepare
		popd >/dev/null || die
	fi

	# eapply "${FILESDIR}/request-pipeline.patch"
	eapply "${FILESDIR}/${P}_libforensic-exception.patch"
	eapply "${FILESDIR}/${P}_add_gcc-8.0+_support.patch"

	sed -e "s#DESTINATION lib#DESTINATION $(get_libdir)#" \
		-i "${S}/CMakeLists.txt" || die "sed failed!"

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(usex static-libs \
			"-DFORENSIC1394_BUILD_STATIC=TRUE" \
			"-DFORENSIC1394_BUILD_STATIC=FALSE")
	)

	if use python; then
		pushd python >/dev/null || die
		distutils-r1_src_configure
		popd >/dev/null || die
	fi

	cmake-utils_src_configure
}

src_compile() {
	if use python; then
		pushd python >/dev/null || die
		distutils-r1_src_compile
		popd >/dev/null || die
	fi

	cmake-utils_src_compile
}

src_install() {
	if use python; then
		pushd python >/dev/null || die
		distutils-r1_src_install
		popd >/dev/null || die
	fi

	cmake-utils_src_install

# TODO: enable access to all nodes
# files/61-libforensic.rules
}

pkg_postinst() {
	einfo "\nMake sure that the old firewire stack is not enabled"
	einfo "The following modules must be unloaded:"
	einfo "    ~# modprobe -r ohci1394 sbp2 eth1394 dv1394 raw1394 video1394\n"
}
