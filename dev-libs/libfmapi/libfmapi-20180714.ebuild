# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator autotools

MY_PV="$(get_major_version)"
MY_PV2="experimental"
#$(get_after_major_version)"

DESCRIPTION="Library  for MAPI data types"
HOMEPAGE="https://github.com/libyal/${PN}"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_PV}/${PN}-${MY_PV2}-${MY_PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="nls"

DEPEND="dev-libs/libcdata
	dev-libs/libcerror
	dev-libs/libcnotify
	dev-libs/libcthreads
	dev-libs/libfdatetime
	dev-libs/libfguid
	dev-libs/libfwnt
	dev-libs/libuna"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		--with-libcdata --with-libcerror \
		--with-libcnotify --with-libcthreads \
		--with-libfdatetime --with-libfguid \
		--with-libfwnt --with-libuna
}
