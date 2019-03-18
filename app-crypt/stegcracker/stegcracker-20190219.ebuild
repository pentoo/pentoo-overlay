# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Steganography brute-force utility to uncover hidden data inside files."
HOMEPAGE="https://github.com/Paradoxis/StegCracker"
COMMIT="5f656b310033a1cc599676bcef742f25e70f6141"
MY_P="StegCracker-${COMMIT}"
SRC_URI="https://github.com/Paradoxis/StegCracker/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	dobin stegcracker
}
