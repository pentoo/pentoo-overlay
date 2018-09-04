# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Steganography brute-force utility to uncover hidden data inside files."
HOMEPAGE="https://github.com/Paradoxis/StegCracker"
COMMIT="102ee64d4efd60f98a84cdabb185bfd5208778da"
MY_P="StegCracker-${COMMIT}"
SRC_URI="https://github.com/Paradoxis/StegCracker/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	dobin stegcracker
}

