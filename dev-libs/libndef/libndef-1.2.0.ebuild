# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2
DESCRIPTION="a C++ library for NDEF specification"
HOMEPAGE="https://github.com/nfc-tools/libndef"
SRC_URI="https://github.com/nfc-tools/libndef/archive/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${P}"

src_configure() {
	eqmake4 "${S}"/libndef.pro PREFIX=/usr
}
