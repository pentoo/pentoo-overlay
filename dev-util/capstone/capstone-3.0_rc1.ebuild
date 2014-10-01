# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

inherit eutils multilib

MY_PV=${PV//_/-}
DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
#IUSE="python"

#RDEPEND="python? ( >=dev-python/capstone-python-${PV} )"
RDEPEND=""
DEPEND=""
#TODO: add java and ocaml bindings

S=${WORKDIR}/${PN}-${MY_PV}

#src_prepare() {
#	if use !test; then
#		sed -i '/$(MAKE) -C tests/d' Makefile || die "sed failed"
#		sed -i '/$(INSTALL_DATA) lib$(LIBNAME).$(EXT) tests/d' Makefile || die "sed failed"
#	fi
#}

#src_configure
#It is actually possible to compile with using cmake

src_install() {
	emake DESTDIR="${ED}" LIBDIRARCH=$(get_libdir) install
#	if use !test; then
#		dodir /usr/share/"${PN}"/
#		cp -R "${S}"/tests "${D}/usr/share/${PN}/" || die "Install failed!"
#	fi
	dodoc README
}
