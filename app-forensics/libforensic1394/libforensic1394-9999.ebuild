# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

CMAKE_IN_SOURCE_BUILD=1

inherit distutils-r1 cmake-utils linux-info git-r3

DESCRIPTION="Library for carrying out memory forensics using firewire/ieee1394."
HOMEPAGE="https://freddie.witherden.org/tools/libforensic1394/"
EGIT_REPO_URI="https://github.com/FreddieWitherden/libforensic1394.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""

IUSE="python"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="python? ( ${PYTHON_DEPS} )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

pkg_setup() {
	CONFIG_CHECK="~FIREWIRE_OHCI"
	linux-info_pkg_setup
}

src_prepare() {
	sed -e "s#DESTINATION lib#DESTINATION $(get_libdir)#" \
		-i "${S}/CMakeLists.txt"
	# epatch "${FILESDIR}/request-pipeline.patch"
}

src_compile() {
	cmake-utils_src_compile
	if $(use python); then
		einfo "Compiling python modules..."
		cd "${S}/python"
		distutils-r1_src_compile
	fi
}

src_install() {
	cmake-utils_src_install
	if $(use python); then
		einfo "Installing python modules..."
		cd "${S}/python"
		distutils-r1_src_install
	fi

# TODO: enable access to all nodes
# files/61-libforensic.rules
}

pkg_postinst() {
	einfo "Make sure that the old firewire stack is not enabled"
	einfo "The following modules must be unloaded:"
	einfo "modprobe -r ohci1394 sbp2 eth1394 dv1394 raw1394 video1394"
}
