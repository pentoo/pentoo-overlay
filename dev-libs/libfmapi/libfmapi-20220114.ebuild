# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for MAPI data types"
HOMEPAGE="https://github.com/libyal/libfmapi"
SRC_URI="https://github.com/libyal/libfmapi/releases/download/${PV}/${PN}-experimental-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls debug +threads"

DEPEND="
	dev-libs/libcdata[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcthreads[nls=]
	dev-libs/libfdatetime[nls=]
	dev-libs/libfguid[nls=]
	dev-libs/libfwnt[nls=]
	dev-libs/libuna[nls=]
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
		$(use_with nls libintl-prefix) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable threads multi-threading-support)

#  --enable-winapi         enable WINAPI support for cross-compilation
#                          [default=auto-detect]
# not supported in the ebuild at the moment - requires windows.h, does not make much sense for us
}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
