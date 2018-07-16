# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The DWARF Debugging Information Format"
HOMEPAGE="https://www.prevanders.net/dwarf.html"
SRC_URI="https://www.prevanders.net/alpha-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="virtual/libelf"
RDEPEND="${DEPEND}"

src_install(){
	emake DESTDIR="${D}" install
#	doheader libdwarf/dwarf.h libdwarf/dwarf.h
	insinto /usr/include/libdwarf
	doins libdwarf/dwarf.h
}
