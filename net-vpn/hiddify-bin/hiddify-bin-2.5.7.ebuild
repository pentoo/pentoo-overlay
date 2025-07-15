# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="hiddify"
inherit unpacker desktop

DESCRIPTION="Multi-platform auto-proxy client"
HOMEPAGE="https://hiddify.com/"
SRC_URI="https://github.com/hiddify/hiddify-app/releases/download/v${PV}/Hiddify-Debian-x64.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="GPL-3 Hiddify"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-libs/libayatana-appindicator"

RESTRICT="bindist mirror"
QA_PREBUILT="*"

src_install() {
	insinto /usr/share/${MY_PN}
	doins -r usr/share/${MY_PN}/*
	fperms +x /usr/share/hiddify/{hiddify,HiddifyCli}

	dosym -r /usr/share/${MY_PN}/hiddify /usr/bin/hiddify

	doicon usr/share/icons/hicolor/128x128/apps/hiddify.png
	make_desktop_entry hiddify "Hiddify" /usr/share/pixmaps/hiddify.png "Network;System"
}
