# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="A GPU-based MD5 MD4 NTLM bruteforcer"
HOMEPAGE="http://www.cryptohaze.com/"
SRC_URI="http://www.cryptohaze.com/releases/CUDA-Multiforcer-src-${PV}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
IUSE=""
SLOT="0"
DEPEND="dev-util/nvidia-cuda-sdk
	=dev-libs/argtable-2*
	x11-drivers/nvidia-drivers"
RDEPEND="${DEPEND}"
S="${WORKDIR}/CUDA-Multiforcer-Release"

src_compile() {
	epatch "${FILESDIR}/multiforcer-0.7-path.patch"
	# We have it installed
	rm -rf argtable2-9
	emake || die "emake failed"
}

src_install() {
	dobin bin/linux/release/cuda-multiforcer  || die "dobin failed"
	insinto /usr/share/cuda-multiforcer
	doins -r charsets test_hashes
	dodoc doc/*
}
