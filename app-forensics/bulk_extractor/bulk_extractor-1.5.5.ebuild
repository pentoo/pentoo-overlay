# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Scans a disk image, directory or file and extracts useful information"
HOMEPAGE="http://www.forensicswiki.org/wiki/Bulk_extractor"
SRC_URI="http://digitalcorpora.org/downloads/bulk_extractor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="exiv2 +ewf +aff sqlite"

DEPEND="aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )
	sqlite? ( dev-db/sqlite )
	exiv2? ( media-gfx/exiv2 )
	dev-libs/boost[threads]
	dev-libs/expat
	dev-libs/openssl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

#DOCS=( AUTHORS ChangeLog README doc/2013.COSE.bulk_extractor.pdf doc/bulk_extractor.html )
