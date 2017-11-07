# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Utilise Pixie Dust Attack to find the correct WPS PIN."
HOMEPAGE="https://github.com/t6x/reaver-wps-fork-t6x"
SRC_URI="https://github.com/t6x/reaver-wps-fork-t6x/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!net-wireless/reaver
	net-libs/libpcap
	dev-db/sqlite:3"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD="1"

S="${WORKDIR}/${P}/src"

src_prepare() {
#	fixme:
	sed -i 's|@localstatedir@/lib/|@localstatedir@/|' config.mak.in
	eapply_user
}

src_compile() {
	cd src
	emake -j1
}
