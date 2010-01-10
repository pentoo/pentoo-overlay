# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Closed Broadcom Commercial Firmware Installer"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+b43 +b43legacy +reload"

DEPEND="net-wireless/broadcom-firmware-downloader[b43?,b43legacy?]
	net-wireless/b43-fwcutter"

RDEPEND=""

#add a check in src_prepare or something to check kernel versions. we don't care, but gentoo will and we like that.

src_install() {
	dodir /lib/firmware || die "failed to create /lib/firmware"
	FIRMWARE_INSTALL_DIR="${D}/lib/firmware"
	use b43 && b43-fwcutter -w "${FIRMWARE_INSTALL_DIR}" ${ROOT}/lib/firmware/broadcom-unmodified/wl_apsta_mimo.o || die "failed to cut xxx firmware"
	use b43legacy && b43-fwcutter -w "${FIRMWARE_INSTALL_DIR}" ${ROOT}/lib/firmware/broadcom-unmodified/wl_apsta-3.130.20.0.o || die "failed to cut xxx firmware"
}

pkg_postinst(){
	if use reload; then
		isloaded() {
			lsmod | grep -q "$1[^_-]"
		}
		isloaded b43 && modprobe -r b43 && sleep 2 && modprobe b43
		isloaded b43legacy && modprobe -r b43legacy && sleep 2 && modprobe b43legacy

		einfo "Your disgusting Broadcom now has its filthy closed source firmware. I hope you are happy."
	else
		einfo "You need to reload your b43* modules manually or set the reload use flag"
	fi
}
