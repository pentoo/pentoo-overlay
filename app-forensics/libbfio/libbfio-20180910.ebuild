# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Library for providing a basic file input/output abstraction layer"
HOMEPAGE="https://github.com/libyal/libbfio"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="nls unicode"

DEPEND="dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcsplit
	dev-libs/libuna
	dev-libs/libcfile
	dev-libs/libcpath
	"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		--with-libcerror \
		--with-libcthreads \
		--with-libcdata \
		--with-libclocale \
		--with-libcnotify \
		--with-libcsplit \
		--with-libuna \
		--with-libcfile \
		--with-libcpath
}
