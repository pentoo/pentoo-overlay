# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="a library for high level manipulation of MIFARE tags"
HOMEPAGE="https://code.google.com/p/nfc-tools/"
SRC_URI="https://nfc-tools.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lib/libnfc"
RDEPEND="${DEPEND}"

src_install() {
	DESTDIR="${D}" emake install || die
}
