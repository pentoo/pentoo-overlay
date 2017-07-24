# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib toolchain-funcs

MY_PV="${PV//_/-}"

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/3" # libcapstone.so.3
KEYWORDS="~amd64 ~arm ~x86"
IUSE="python"

PDEPEND="python? ( >=dev-python/capstone-python-${PV} )"
RDEPEND=""
DEPEND="${RDEPEND}"
#TODO: add java and ocaml bindings

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=(
	"${FILESDIR}/pull939.patch"
)

src_configure() {
	{
		cat <<-EOF
		# Gentoo overrides:
		#   verbose build
		V = 1
		#   toolchain
		AR = $(tc-getAR)
		CC = $(tc-getCC)
		RANLIB = $(tc-getRANLIB)
		#  toolchain flags
		CFLAGS = ${CFLAGS}
		LDFLAGS = ${LDFLAGS}
		#  libs
		LIBDIRARCH = $(get_libdir)
		EOF
	} >> config.mk || die

}
