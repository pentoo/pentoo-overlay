# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit subversion

DESCRIPTION="An open source wireless development platform suitable for Bluetooth experimentation"
HOMEPAGE="http://ubertooth.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ubertooth0 +ubertooth1"

DEPEND="net-wireless/ubertooth[dfu]
		sys-devel/gcc-arm-embedded-bin"

ESVN_REPO_URI="https://ubertooth.svn.sourceforge.net/svnroot/ubertooth/trunk/firmware"

src_compile() {
	cd "${S}"/bluetooth_rxtx
	if use ubertooth0; then
		SVN_REV_NUM="-D'SVN_REV_NUM'=${ESVN_WC_REVISION}" DFU_TOOL=/usr/bin/ubertooth-dfu BOARD=UBERTOOTH_ZERO emake -j1
		mv bluetooth_rxtx.bin bluetooth_rxtx_U0.bin
		emake clean
	fi
	if use ubertooth1; then
		SVN_REV_NUM="-D'SVN_REV_NUM'=${ESVN_WC_REVISION}" DFU_TOOL=/usr/bin/ubertooth-dfu emake -j1
		mv bluetooth_rxtx.bin bluetooth_rxtx_U1.bin
	fi
}

src_install() {
	insinto /lib/firmware
	use ubertooth0 && doins bluetooth_rxtx/bluetooth_rxtx_U0.bin
	use ubertooth1 && doins bluetooth_rxtx/bluetooth_rxtx_U1.bin
}

