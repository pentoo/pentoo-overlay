# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Closed Broadcom Commercial Firmware Downloader"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/b43"
SRC_URI="b43? ( http://www.lwfinger.com/b43-firmware/broadcom-wl-5.100.138.tar.bz2 )
	b43legacy? ( http://downloads.openwrt.org/sources/wl_apsta-3.130.20.0.o )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+b43 +b43legacy"
RESTRICT="strip"

DEPEND=""
RDEPEND="net-wireless/b43-fwcutter"

src_install() {
	dodir /lib/firmware/broadcom-unmodified || die "failed to create dir"
	insinto /lib/firmware/broadcom-unmodified
	if use b43; then doins "${WORKDIR}"/broadcom-wl-5.100.138/linux/wl_apsta.o || die "failed to install b43 files"; fi;
	if use b43legacy; then doins "${DISTDIR}"/wl_apsta-3.130.20.0.o || die "failed to install b43legacy files"; fi;
	einfo "Unmolested Broadcom firmware files have been downloaded from openwrt and stored on the hdd."
	einfo "No changes to the files have been made, only unmodified files have been distributed."
	einfo "If the user wishes these firmware in a useful way then emerge broadcom-firmware-installer."
}
