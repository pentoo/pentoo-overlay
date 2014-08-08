# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-2.0_beta1-r2.ebuild,v 1.4 2013/03/02 20:43:31 hwoarang Exp $

EAPI=4
inherit qt4-r2 eutils cmake-utils

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="https://sqlitebrowser.org"
SRC_URI="https://github.com/sqlitebrowser/sqlitebrowser/archive/sqlb-3.2.0.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-sqlb-${PV}

src_install() {
	cmake-utils_src_install
	doicon images/sqlitebrowser.svg
	domenu distri/sqlitebrowser.desktop
}
