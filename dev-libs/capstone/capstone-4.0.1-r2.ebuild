# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/4" # libcapstone.so.4
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
#keep python flag for compatibility with Gentoo
IUSE="python test"

PDEPEND=">=dev-libs/capstone-bindings-${PV}[python?]"
RDEPEND=""
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-4.0-cmake.patch
	"${FILESDIR}"/${PN}-4.0-FLAGS.patch
	"${FILESDIR}"/${PN}-4.0-no-fuzz-tests.patch
)

src_configure() {
	if ! use test; then
		# Don't build tests if not requested: bug #663006
		sed -i tests/Makefile -e 's@all: $(BINARY)@all:@' || die
	fi
}
