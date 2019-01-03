# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Direct Memory Access (DMA) Attack Software"
HOMEPAGE="https://github.com/ufrisk/pcileech"
SRC_URI="https://github.com/ufrisk/pcileech/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ft60x_driver"

DEPEND="virtual/libusb:1
	ft60x_driver? ( sys-kernel/ft60x_driver )"
RDEPEND="${DEPEND}"

src_prepare() {
	#https://github.com/ufrisk/pcileech/issues/68
	sed -i "s|ULONG64 qwA;|QWORD qwA;|" pcileech/pcileech.h
	eapply_user
}

src_compile() {
	emake -C pcileech
}

src_install(){
	dobin pcileech/pcileech
}
