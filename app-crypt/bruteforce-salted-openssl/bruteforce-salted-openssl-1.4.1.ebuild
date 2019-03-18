# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A bruteforce cracker for openssl encrypted files."
HOMEPAGE="https://github.com/glv2/${PN}"
SRC_URI="https://github.com/glv2/${PN}/releases/download/${PV}/${P}.tar.xz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="dev-libs/openssl:*"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}

#src_install() {
#	default
#	dodoc AUTHORS ChangeLog NEWS README
#}
