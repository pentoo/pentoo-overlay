# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for cross-platform C file functions"
HOMEPAGE="https://github.com/libyal/libcfile"
SRC_URI="https://github.com/libyal/libcfile/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls unicode debug"

# This library has a circular build-time dependency on libuna. According to upstream, this is
# a non-issue as long as we use the pre-assembled download tarballs because they contain all
# required sources (see https://github.com/libyal/libuna/issues/7). In this case, we set a
# unilateral dependency libfile --> libuna and hope for the best. (Dependent packages should
# include both packages as dependency.)

# diffball has embedded libcfile library which collides with this package
# https://github.com/zmedico/diffball/issues/5
DEPEND="
	!dev-util/diffball
	dev-libs/libcerror[nls=]
	dev-libs/libclocale[nls=,unicode=]
	dev-libs/libcnotify[nls=]
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
		$(use_enable debug debug-output )

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
