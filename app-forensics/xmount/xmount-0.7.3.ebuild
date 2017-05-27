# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/xmount_${PV}.orig.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"
KEYWORDS="~amd64 ~x86 ~arm"

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

#prepare: we might need files/cmake_c_flags patch on hardened

src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake-utils_src_configure
}
