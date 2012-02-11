# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit qt4-r2
DESCRIPTION="a C++ library for NDEF specification"
HOMEPAGE="https://code.google.com/p/libndef/"
SRC_URI="https://libndef.googlecode.com/files/${P}.zip"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 "${S}"/libndef.pro PREFIX=/usr
}
