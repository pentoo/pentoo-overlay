# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The DWARF Debugging Information Format"
HOMEPAGE="https://www.prevanders.net/dwarf.html"
SRC_URI="https://www.prevanders.net/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="${DEPEND}"

src_configure() {
	econf --includedir="${EPREFIX}/usr/include/${PN}"
}

#src_install(){
#	emake DESTDIR="${D}" install
#}
