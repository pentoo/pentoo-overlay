# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a library for high level manipulation of MIFARE tags"
HOMEPAGE="https://github.com/nfc-tools/libfreefare"
SRC_URI="https://github.com/nfc-tools/libfreefare/archive/${P%-r*}.tar.gz -> ${P%-r*}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libnfc
		dev-libs/openssl:=
		virtual/libusb:0"

RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${PN}-${P%-r*}"

src_prepare() {
	eapply "${FILESDIR}"/${PN}-0.4.0-stdlib.patch
	eapply_user
	eautoreconf
}
