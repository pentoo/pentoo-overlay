# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Direct Memory Access (DMA) Attack Software"
HOMEPAGE="https://github.com/ufrisk/pcileech"
SRC_URI="https://github.com/ufrisk/pcileech/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake -C pcileech
}

src_install(){
	dobin pcileech/pcileech
}
