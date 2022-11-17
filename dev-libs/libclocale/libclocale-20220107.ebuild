# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library for cross-platform C locale functions"
HOMEPAGE="https://github.com/libyal/libclocale"
SRC_URI="https://github.com/libyal/libclocale/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls unicode"

DEPEND="
	dev-libs/libcerror
	nls? (
		virtual/libiconv
		virtual/libintl
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type)

#  --disable-shared-libs   disable shared library support
# not supported in the ebuild at the moment - kind of defeats the entire process

#  --enable-winapi         enable WINAPI support for cross-compilation
#                          [default=auto-detect]
# not supported in the ebuild at the moment - requires windows.h, does not make much sense for us
}
