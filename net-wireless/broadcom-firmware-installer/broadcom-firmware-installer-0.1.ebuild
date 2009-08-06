# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Closed Broadcom Commercial Firmware Installer"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="b43 b43legacy"
EAPI=2

DEPEND="b43? ( net-wireless/broadcom-firmware-downloader[b43] )
	b43legacy? ( net-wireless/broadcom-firmware-downloader[b43legacy] )
	( || ( net-wireless/b43-fwcutter ) ( net-wireless/b43-tools[fwcutter] ) )"

src_install() {
	export FIRMWARE_INSTALL_DIR="/lib/firmware"
	b43-fwcutter -w "$FIRMWARE_INSTALL_DIR" /lib/firmware/broadcom_unmodified/wl_apsta_mimo.o
	b43-fwcutter -w "$FIRMWARE_INSTALL_DIR" /lib/firmware/broadcom_unmodified/wl_apsta-3.130.20.0.o
	einfo "Your disgusting Broadcom now has it's filthy close source firmware. I hope you are happy."
}

