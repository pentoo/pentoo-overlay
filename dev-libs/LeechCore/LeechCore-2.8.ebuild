# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Direct Memory Access (DMA) Attack Software"
HOMEPAGE="https://github.com/ufrisk/LeechCore"
SRC_URI="https://github.com/ufrisk/LeechCore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="virtual/libusb:*"
RDEPEND="${DEPEND}"

src_prepare() {
	#https://github.com/ufrisk/LeechCore/issues/26
	emake -C leechcore clean
	sed -i '/CFLAGS  += -fPIE /d' leechcore/Makefile || die

	eapply_user
}

src_compile() {
	emake -C leechcore
}

src_install(){
	dolib.so files/leechcore.so
}
