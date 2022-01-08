# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop udev xdg

MY_PN="${PN%-bin}"

DESCRIPTION="Codeplug editor for the MD-380/MD-390/MD40/MD-UV380/MD-UV390 DMR radios"
HOMEPAGE="https://www.farnsworth.org/dale/codeplug/editcp"
SRC_URI="https://www.farnsworth.org/dale/codeplug/editcp/downloads/linux/editcp-${PV}.tar.xz
https://www.farnsworth.org/dale/codeplug/editcp/downloads/linux/previous/editcp-${PV}.tar.xz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

RESTRICT="strip"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtserialport:5
	dev-libs/libpcre:=
	!net-wireless/editcp
	virtual/libusb:1"

QA_DT_NEEDED="opt/${MY_PN}/(lib|plugins/.*)/lib.*[.]so[.][0-9]\+"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default

	sed -i \
		-e "s|^dirname=\(.*\)|dirname=/opt/${MY_PN}|" \
		-e "s|\(\"\$dirname/\$appname\" \"\$@\"\)|exec \1|" ${MY_PN}.sh || die

	rm install
}

src_install() {
	insinto "/opt/${MY_PN}"
	insopts -m0755
	doins -r lib/ plugins/
	doins *.sh editcp

	dosym  "../${MY_PN}/${MY_PN}.sh" "/opt/bin/${MY_PN}"

	udev_dorules 99-md380.rules

	make_desktop_entry $MY_PN "Editcp (bin)" $MY_PN "Utility"
}

pkg_postinst() {
	xdg_desktop_database_update
	udev_reload
}

pkg_postrm() {
	xdg_desktop_database_update
	udev_reload
}
