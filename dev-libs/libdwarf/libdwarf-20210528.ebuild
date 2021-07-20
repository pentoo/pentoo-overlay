# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The DWARF Debugging Information Format"
HOMEPAGE="https://www.prevanders.net/dwarf.html"
SRC_URI="https://www.prevanders.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

#DEPEND="virtual/libelf"
DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	#Upstream: The libelf interfaces and declarations and code should be removed
	econf --disable-libelf --includedir="${EPREFIX}/usr/include/${PN}"
}

src_install(){
	emake DESTDIR="${D}" install
}
