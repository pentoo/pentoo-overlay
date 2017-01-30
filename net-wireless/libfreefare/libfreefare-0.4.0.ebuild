# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit autotools

DESCRIPTION="a library for high level manipulation of MIFARE tags"
HOMEPAGE="https://github.com/nfc-tools/libfreefare"
SRC_URI="https://github.com/nfc-tools/libfreefare/archive/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libnfc
		dev-libs/openssl:=
		virtual/libusb:0"

RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${PN}-${P}"

src_prepare() {
	eapply_user
	eautoreconf
}
