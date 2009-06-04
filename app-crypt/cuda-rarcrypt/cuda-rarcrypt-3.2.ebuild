# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="A Nvidia GPU-based RAR bruteforcer"
HOMEPAGE="http://www.crark.net/"
SRC_URI="http://www.crark.net/Cuda-OpenSrc.rar"

LICENSE="GPL-3"
KEYWORDS="x86"
IUSE=""
SLOT="0"
DEPEND="dev-util/nvidia-cuda-sdk"
RDEPEND="${DEPEND}"
S="${WORKDIR}/"

src_compile() {
	epatch "${FILESDIR}/cuda-rarcrypt-path.patch"
	emake || die "emake failed"
}

src_install() {
	dobin bin/linux/release/cuda-rarcrypt  || die "dobin failed"
	dodoc readme
}
