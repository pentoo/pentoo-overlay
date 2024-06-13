# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for providing a basic file input/output abstraction layer"
HOMEPAGE="https://github.com/libyal/libbfio"
SRC_URI="https://github.com/libyal/libbfio/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

# It would make more sense to put this package in dev-libs/ instead of app-forensics/,
# but this is where it is in the main Gentoo repository, so we'll just stick with that.

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls +threads unicode debug"

DEPEND="
	dev-libs/libcdata[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libcfile[nls=,unicode=]
	dev-libs/libclocale[nls=,unicode=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcpath[nls=,unicode=]
	dev-libs/libcsplit[nls=,unicode=]
	dev-libs/libcthreads[nls=]
	dev-libs/libuna[nls=,unicode=]
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
		$(use_enable unicode wide-character-type) \
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \
		$(use_enable threads multi-threading-support)

#  --disable-shared-libs   disable shared library support
# not supported in the ebuild at the moment - kind of defeats the entire process

#  --enable-winapi         enable WINAPI support for cross-compilation
#                          [default=auto-detect]
# not supported in the ebuild at the moment - requires windows.h, does not make much sense for us
}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
