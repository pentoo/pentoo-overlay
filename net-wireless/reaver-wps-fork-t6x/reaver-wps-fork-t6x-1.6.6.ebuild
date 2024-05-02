# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utilise Pixie Dust Attack to find the correct WPS PIN."
HOMEPAGE="https://github.com/t6x/reaver-wps-fork-t6x"
SRC_URI="https://github.com/t6x/reaver-wps-fork-t6x/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}/src"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="!net-wireless/reaver
	net-libs/libpcap
	dev-db/sqlite:3"
RDEPEND="${DEPEND}"
PDEPEND="net-wireless/pixiewps"

src_configure() {
	econf --localstatedir="${EPREFIX}"/var
}

src_install() {
	emake DESTDIR="${D}" install
	keepdir /var/lib/reaver
}
