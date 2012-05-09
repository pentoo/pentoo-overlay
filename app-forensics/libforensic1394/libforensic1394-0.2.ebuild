# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
SUPPORT_PYTHON_ABIS="1"

inherit eutils cmake-utils linux-info python distutils

DESCRIPTION="Library for carrying out memory forensics using firewire/ieee1394."
HOMEPAGE="http://freddie.witherden.org/tools/libforensic1394/"
SRC_URI="https://freddie.witherden.org/tools/${PN}/releases/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

#FIXME: fails to compile without the "python" flag
#IUSE="python"
IUSE=""

pkg_setup() {
	CONFIG_CHECK="~FIREWIRE_OHCI"
	linux-info_pkg_setup
}

src_prepare() {
	# epatch "${FILESDIR}/request-pipeline.patch"
	epatch "${FILESDIR}/libforensic-exception.patch"
	sed -e "s#DESTINATION lib#DESTINATION $(get_libdir)#" \
		-i "${S}/CMakeLists.txt"
}

src_compile() {
	cmake-utils_src_compile
#	if use python; then
		einfo "Compiling python modules..."
		cd "${S}/python"
		distutils_src_compile
#	fi
}

src_install() {
	cmake-utils_src_install
#	if use python; then
		einfo "Installing python modules..."
		cd "${S}/python"
		distutils_src_install
#	fi

# TODO: enable access to all nodes
# files/61-libforensic.rules
}

pkg_postinst() {
	einfo "Make sure that the old firewire stack is not enabled"
	einfo "The following modules must be unloaded:"
	einfo "modprobe -r ohci1394 sbp2 eth1394 dv1394 raw1394 video1394"
}
