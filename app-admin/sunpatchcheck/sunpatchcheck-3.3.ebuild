# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Sun Missing Patch checker"
HOMEPAGE="http://www.titania.co.uk/"
SRC_URI="http://titania.co.uk/downloads/titanialabs/tools/${P}.tgz"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodir /var/lib/${PN}
}
