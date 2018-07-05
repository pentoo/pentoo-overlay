# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib toolchain-funcs

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
MY_COMMIT="37569a6874c8547b349a80823adda9284499fe80"
SRC_URI="https://github.com/aquynh/${PN}/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0/3" # libcapstone.so.3
KEYWORDS="~amd64 ~arm ~x86"
IUSE="python"

#PDEPEND="python? ( >=dev-python/capstone-python-${PV} )"

RDEPEND=""
DEPEND="${RDEPEND}"
#TODO: add java and ocaml bindings

PATCHES=(
	"${FILESDIR}/capstone-calloc.patch"
	"${FILESDIR}/fix-m68k-oob.patch"
	"${FILESDIR}/fix-underflow-tms.patch"
	"${FILESDIR}/fix-x86-16.patch"
	"${FILESDIR}/sparc-crash.patch"
	"${FILESDIR}/sstream-null.patch"
)

S="${WORKDIR}/${PN}-${MY_COMMIT}"

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
