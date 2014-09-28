# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Scans a disk image, directory or file and extracts useful information"
HOMEPAGE="http://www.forensicswiki.org/wiki/Bulk_extractor"
SRC_URI="http://digitalcorpora.org/downloads/bulk_extractor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-gfx/exiv2
	sys-libs/zlib
	dev-libs/expat
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README NEWS
}
