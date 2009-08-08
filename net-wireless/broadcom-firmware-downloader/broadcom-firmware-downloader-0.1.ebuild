# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Closed Broadcom Commercial Firmware Downloader"
HOMEPAGE=""
SRC_URI="b43? ( http://mirror2.openwrt.org/sources/broadcom-wl-4.150.10.5.tar.bz2 )
	b43legacy? ( http://downloads.openwrt.org/sources/wl_apsta-3.130.20.0.o )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+b43 +b43legacy"
RESTRICT="strip"

DEPEND=""

#RDEPEND="( || ( net-wireless/b43-fwcutter ) ( net-wireless/b43-tools[fwcutter] ) )"
RDEPEND="net-wireless/b43-tools[fwcutter]"

src_install() {
        dodir /lib/firmware/broadcom-unmodified
	insinto /lib/firmware/broadcom-unmodified
	if use b43; then doins "${WORKDIR}"/broadcom-wl-4.150.10.5/driver/wl_apsta_mimo.o; fi;
	if use b43legacy; then doins "${DISTDIR}"/wl_apsta-3.130.20.0.o; fi;
	einfo "Unmolested Broadcom firmware files have been downloaded from openwrt and stored on the hdd."
	einfo "No changes to the files have been made, only unmodified files have been distributed."
	einfo "If the user wishes these firmware in a useful way then emerge broadcom-firmware-installer."
}

