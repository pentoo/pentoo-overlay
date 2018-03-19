# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Bruteforce offline the WPS pin exploiting the low or non-existing entropy"
HOMEPAGE="https://github.com/wiire/pixiewps"
SRC_URI="https://github.com/wiire/pixiewps/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl:0"
RDEPEND="${DEPEND}"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
	dodoc README.md
}
