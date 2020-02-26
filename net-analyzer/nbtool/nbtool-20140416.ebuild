# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils toolchain-funcs

DESCRIPTION="Some tools for NetBIOS and DNS investigation, attacks, and communication"
HOMEPAGE="https://www.skullsecurity.org/wiki/index.php/Nbtool"

HASH_COMMIT="bf90c76221c3005ef537f587dd267f085551d014"
SRC_URI="https://github.com/iagox86/nbtool/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/nbtool-makefile.patch )

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGELOG TODO
}
