# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for GUID/UUID format"
HOMEPAGE="https://github.com/libyal/libfguid"
SRC_URI="https://github.com/libyal/libfguid/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls"

DEPEND="
	dev-libs/libcerror[nls=]
	nls? (
		virtual/libiconv
		virtual/libintl
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix)

#  --enable-winapi         enable WINAPI support for cross-compilation
#                          [default=auto-detect]
# not supported in the ebuild at the moment - requires windows.h, does not make much sense for us
}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
