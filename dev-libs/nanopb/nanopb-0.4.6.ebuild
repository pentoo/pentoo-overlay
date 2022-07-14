# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="plain-C Protocol Buffers for embedded/memory-constrained systems"
HOMEPAGE="http://koti.kapsi.fi/jpa/nanopb/"
SRC_URI="http://koti.kapsi.fi/~jpa/nanopb/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="doc examples"

RDEPEND="
	dev-libs/protobuf
"
DEPEND="
	dev-util/scons
	${RDEPEND}
"

S="${WORKDIR}/${PN}"

src_test() {
	cd "${S}"/tests
	scons
}
