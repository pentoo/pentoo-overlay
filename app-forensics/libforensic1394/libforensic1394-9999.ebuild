# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils cmake-utils git-2

DESCRIPTION="Library for carrying out memory forensics using firewire/ieee1394."
HOMEPAGE="http://freddie.witherden.org/tools/libforensic1394/"
SRC_URI=""
EGIT_REPO_URI="git://git.freddie.witherden.org/forensic1394.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-x86 -amd64"

#IUSE="python"
IUSE=""

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
#	if $(use python); then
		einfo "Compiling python modules..."
		cd "${S}/python"
		distutils_src_compile
#	fi
}

src_install() {
	cmake-utils_src_install
#	if $(use python); then
		einfo "Installing python modules..."
		cd "${S}/python"
		distutils_src_install
#	fi
}

pkg_postinst() {
	einfo "Make sure that the old firewire stack is not enabled"
	einfo "The following modules must be unloaded:"
	einfo "modprobe -r ohci1394 sbp2 eth1394 dv1394 raw1394 video1394"
}
