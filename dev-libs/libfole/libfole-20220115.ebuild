# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for Object Linking and Embedding (OLE) data types"
HOMEPAGE="https://github.com/libyal/libfole"
SRC_URI="https://github.com/libyal/libfole/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls debug"

DEPEND="
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	dev-libs/libcerror[nls=]
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \

}
