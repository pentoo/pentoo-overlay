# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Library for cross-platform C file functions"
HOMEPAGE="https://github.com/libyal/${PN}"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="nls unicode debug"

DEPEND="dev-libs/libcerror
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libuna
	nls? ( virtual/libiconv
		virtual/libintl )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \
		--with-libcerror --with-libclocale \
		--with-libcnotify --with-libuna
}
