# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit multilib toolchain-funcs

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/3" # libcapstone.so.3
KEYWORDS="~amd64 ~arm ~x86"
IUSE="python"

RDEPEND="python? ( >=dev-python/capstone-python-${PV} )"
RDEPEND=""
DEPEND="${RDEPEND}"
#TODO: add java and ocaml bindings

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

#the old style
#src_install() {
#	emake DESTDIR="${ED}" LIBDIRARCH=$(get_libdir) install
#	if use !test; then
#		dodir /usr/share/"${PN}"/
#		cp -R "${S}"/tests "${D}/usr/share/${PN}/" || die "Install failed!"
#	fi
#	dodoc README
#}
