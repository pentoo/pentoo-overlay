# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The DWARF Debugging Information Format"
HOMEPAGE="https://www.prevanders.net/dwarf.html"
SRC_URI="https://www.prevanders.net/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="virtual/libelf"
RDEPEND="${DEPEND}"

S=${WORKDIR}/dwarf-${PV}

src_install(){
	dobin dwarfdump/dwarfdump
	dolib.a libdwarf/libdwarf.a
	doheader libdwarf/libdwarf.h
	insinto /etc/
	doins dwarfdump/dwarfdump.conf
}
