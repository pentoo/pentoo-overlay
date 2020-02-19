# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://pinguin.lu/xmount"
SRC_URI="https://files.pinguin.lu/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"

BDEPEND="virtual/pkgconfig"
RDEPEND="sys-fs/fuse:*
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}"

src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake_src_configure
}
