# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="https://github.com/libyal/libuna"
SRC_URI="https://github.com/libyal/libuna/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls unicode"

# This library has a circular build-time dependency on libcfile. According to upstream, this is
# a non-issue as long as we use the pre-assembled download tarballs because they contain all
# required sources (see https://github.com/libyal/libuna/issues/7).
# dev-libs/libcfile
DEPEND="
	dev-libs/libcdatetime[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libclocale[nls=,unicode=]
	dev-libs/libcnotify[nls=]
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
