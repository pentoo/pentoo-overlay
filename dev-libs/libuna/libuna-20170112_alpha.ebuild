# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator autotools

MY_PV="$(get_major_version)"
MY_PV2="$(get_after_major_version)"

DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="https://github.com/libyal/${PN}"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_PV}/${PN}-${MY_PV2}-${MY_PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="nls unicode"

#https://github.com/libyal/libuna/issues/7
#	dev-libs/libcfile

DEPEND="dev-libs/libcdatetime
	dev-libs/libcerror
	dev-libs/libclocale
	dev-libs/libcnotify
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		--with-libcdatetime --with-libcerror \
		--with-libclocale --with-libcnotify
}
