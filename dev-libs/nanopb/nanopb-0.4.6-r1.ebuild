# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="plain-C Protocol Buffers for embedded/memory-constrained systems"
HOMEPAGE="https://jpa.kapsi.fi/nanopb/ https://github.com/nanopb/nanopb"
SRC_URI="https://github.com/nanopb/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="doc examples pb-malloc"

RDEPEND="
	dev-libs/protobuf
"
DEPEND="
	dev-util/scons
	${RDEPEND}
"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	use pb-malloc && append-cppflags "-DPB_ENABLE_MALLOC"
	cmake_src_configure
}

src_test() {
	cd "${S}"/tests
	scons
}
