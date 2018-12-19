# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#inherit multilib toolchain-funcs
inherit cmake-utils

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/4" # libcapstone.so.4
KEYWORDS="~amd64 ~arm ~x86"
IUSE="python"

PDEPEND="python? ( >=dev-python/capstone-python-${PV} )"
RDEPEND=""
DEPEND="${RDEPEND}"
#TODO: add java and ocaml bindings

PATCHES=(
#	"${FILESDIR}/capstone-calloc.patch"
#	"${FILESDIR}/fix-m68k-oob.patch"
#	"${FILESDIR}/fix-underflow-tms.patch"
	"${FILESDIR}/fix-x86-16.patch"
	"${FILESDIR}/sparc-crash.patch"
	"${FILESDIR}/sstream-null.patch"
)

#src_configure() {
#	{
#		cat <<-EOF
#		# Gentoo overrides:
#		#   verbose build
#		V = 1
#		#   toolchain
#		AR = $(tc-getAR)
#		CC = $(tc-getCC)
#		RANLIB = $(tc-getRANLIB)
#		#  toolchain flags
#		CFLAGS = ${CFLAGS}
#		LDFLAGS = ${LDFLAGS}
#		#  libs
#		LIBDIRARCH = $(get_libdir)
#		EOF
#	} >> config.mk || die

#}
