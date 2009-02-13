# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


DESCRIPTION="All publicly released Ralink Firmware files from their website"
HOMEPAGE="http://www.ralinktech.com/ralink/Home/Support/Linux.html"
SRC_URI="http://www.ralinktech.com.tw/data/RT61_Firmware_V1.2.zip
	 http://www.ralinktech.com.tw/data/RT71W_Firmware_V1.8.zip
	 http://www.ralinktech.com.tw/data/drivers/RT2870_Firmware_V8.zip
	 http://www.ralinktech.com.tw/data/drivers/RT2860_Firmware_V11.zip"

LICENSE="Ralink"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )
	app-arch/unzip"

src_unpack() {
	for x in ${A}; do unzip ${DISTDIR}/${x}; done
}

src_compile() {
        true;
}

src_install() {
	S="${WORKDIR}"
        insinto /lib/firmware
	 doins "${S}"/RT2860_Firmware_V11/*.bin
	 doins "${S}"/RT61_Firmware_V1.2/*.bin
	 doins "${S}"/RT2870_Firmware_V8/*.bin
	 doins "${S}"/RT71W_Firmware_V1.8/*.bin

        dodoc "${S}"/RT2860_Firmware_V11/LICENSE.ralink-firmware.txt || die "dodoc failed"
}

