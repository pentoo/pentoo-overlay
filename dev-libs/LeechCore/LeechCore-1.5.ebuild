# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Direct Memory Access (DMA) Attack Software"
HOMEPAGE="https://github.com/ufrisk/LeechCore"
SRC_URI="https://github.com/ufrisk/LeechCore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake -C leechcore
}

src_install(){
	dolib.so files/leechcore.so
}
