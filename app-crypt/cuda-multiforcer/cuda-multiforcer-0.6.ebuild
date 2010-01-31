# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="A GPU-based MD5 MD4 NTLM bruteforcer"
HOMEPAGE="http://www.cryptohaze.com/"
SRC_URI="http://www.cryptohaze.com/CUDA-Multiforcer-src-0.6.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-util/nvidia-cuda-sdk
	=dev-libs/argtable-2*"
RDEPEND="${DEPEND}"
S="${WORKDIR}/Multiforcer"

src_compile() {
	epatch "${FILESDIR}/multiforcer-${PV}-path.patch"
	# We have it installed
	rm -rf argtable2-9
	emake
}

src_install() {
	dobin bin/linux/release/cuda-multiforcer
	insinto /usr/share/cuda-multiforcer
	doins -r charsets test_hashes
	dodoc doc/*
}
