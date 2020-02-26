# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Steganography brute-force utility to uncover hidden data inside files"
HOMEPAGE="https://github.com/Paradoxis/StegCracker"

HASH_COMMIT="5f656b310033a1cc599676bcef742f25e70f6141"
SRC_URI="https://github.com/Paradoxis/StegCracker/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="app-crypt/steghide"
DEPEND=""

PATCHES=( "${FILESDIR}/${P}_minor-changes.patch" )

S="${WORKDIR}/StegCracker-${HASH_COMMIT}"

src_install() {
	newbin stegcracker stegcracker-legacy
	dodoc README.md
}
