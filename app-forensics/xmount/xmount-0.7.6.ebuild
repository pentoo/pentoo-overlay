# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils git-r3

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
#workaround: no tar ball for this release
#SRC_URI="https://files.pinguin.lu/${P}.tar.gz"
EGIT_REPO_URI="https://code.pinguin.lu/diffusion/XMOUNT"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"
KEYWORDS="~amd64 ~x86 ~arm"

RDEPEND="sys-fs/fuse:*
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${P}/tags/${P}"

src_unpack(){
	git-r3_fetch ${EGIT_REPO_URI} "refs/tags/v${PV}"
	git-r3_checkout ${EGIT_REPO_URI} "" "" "tags/xmount-${PV}"
}

src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake-utils_src_configure
}
