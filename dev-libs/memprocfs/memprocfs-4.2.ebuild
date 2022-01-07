# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The Memory Process File System"
HOMEPAGE="https://github.com/ufrisk/MemProcFS"
SRC_URI="https://github.com/ufrisk/MemProcFS/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="virtual/libusb:*
	sys-fs/fuse:*
	dev-libs/openssl
	app-arch/lz4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/MemProcFS-${PV}"

src_prepare() {
	sed '/mv leechcore.so/d' -i vmm/Makefile || die
	eapply_user
}

src_compile() {
	emake -C vmm vmm
}

src_install(){
	dolib.so files/vmm.so
}
