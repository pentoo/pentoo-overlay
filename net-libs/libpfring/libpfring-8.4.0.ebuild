# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit multilib 

MY_P="PF_RING-${PV}"

DESCRIPTION="A new type of network socket that improves packet capture speed."
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="https://github.com/ntop/PF_RING/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm64  x86"
IUSE=""

S="${WORKDIR}/${MY_P}/userland/lib"
#S="${WORKDIR}/${MY_P}"

src_prepare(){
	sed -i "s|${INSTDIR}/lib|${INSTDIR}/$(get_libdir)|" Makefile.in || die
	sed -i "s|lib64nbpf.a|libnbpf.a|" Makefile.in || die
	eapply_user
}

#src_compile(){
#	emake -j1
#}

src_install(){
	emake DESTDIR="${D}" install
	dosym libpfring.so usr/$(get_libdir)/libpfring.so.1
}
