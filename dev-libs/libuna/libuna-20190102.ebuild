# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="https://github.com/libyal/libuna"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="nls unicode"

#https://github.com/libyal/libuna/issues/7
#	dev-libs/libcfile

DEPEND="dev-libs/libcdatetime
	dev-libs/libcerror
	dev-libs/libclocale
	dev-libs/libcnotify
	nls? ( virtual/libiconv
		virtual/libintl )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		--with-libcdatetime --with-libcerror \
		--with-libclocale --with-libcnotify
}
