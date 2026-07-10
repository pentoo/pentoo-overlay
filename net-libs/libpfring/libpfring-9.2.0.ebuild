# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="PF_RING-${PV}"

DESCRIPTION="A new type of network socket that improves packet capture speed"
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="https://github.com/ntop/PF_RING/archive/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}/userland/lib"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="~sys-kernel/pf_ring-kmod-${PV}"

BDEPEND="sys-devel/bison
	app-alternatives/lex"

src_prepare(){
	# install shared libraries only
	sed -i "s|install: install-static install-shared|install: install-shared|" Makefile.in || die

	sed -i "s|${INSTDIR}/lib|${INSTDIR}/$(get_libdir)|" Makefile.in || die
	sed -i "s|lib64nbpf.a|libnbpf.a|" Makefile.in || die
	eapply_user
}

src_compile() {
	# bison generates grammar.tab.c and grammar.tab.h together in one
	# invocation; the nbpf Makefile models grammar.tab.h as a side-effect
	# with no recipe, so parallel make (and distcc's local preprocessor)
	# can race against the bison run. Pre-generate serially first.
	emake -j1 -C "${S}/../nbpf" grammar.tab.c grammar.tab.h lex.yy.c
	emake
}

src_install(){
	emake DESTDIR="${D}" install
	dosym libpfring.so usr/$(get_libdir)/libpfring.so.1
}
