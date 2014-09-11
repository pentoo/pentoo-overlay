# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5
inherit cmake-utils

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="https://sqlitebrowser.org"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	doicon images/sqlitebrowser.svg
	domenu distri/sqlitebrowser.desktop
}
