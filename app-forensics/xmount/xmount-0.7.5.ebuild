# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://pinguin.lu/xmount"
SRC_URI="https://files.pinguin.lu/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="sys-fs/fuse:*
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

#prepare: we might need files/cmake_c_flags patch on hardened

src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake-utils_src_configure
}
