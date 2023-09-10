# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

#EGO_PN="github.com/sensepost/gowitness"

DESCRIPTION="A web screenshot utility using Chrome Headless"
HOMEPAGE="https://github.com/sensepost/gowitness"

SRC_URI="https://github.com/sensepost/gowitness/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz"

KEYWORDS="amd64 ~x86"
LICENSE="CC-BY-SA-4.0 GPL-3 AGPL-3"
SLOT="0"

src_compile() {
	ego build
}

src_install() {
	dobin gowitness
	default
}

pkg_postinst() {
	einfo "\nYou need install Google Chrome or chrome based browser before using it"
	einfo "See documentation: https://github.com/sensepost/gowitness#usage\n"
}
