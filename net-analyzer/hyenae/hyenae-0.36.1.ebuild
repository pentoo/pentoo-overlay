# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator
MY_P=${PN}-$(replace_version_separator 2 '-' )

DESCRIPTION="a highly flexible packet generator"
HOMEPAGE="http://sourceforge.net/projects/hyenae/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libdnet
		net-libs/libpcap
		dev-libs/libnl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e 's|$(DESTDIR)$(bindir)|$(DESTDIR)$(sbindir)|' -i src/Makefile.in || die "sed Makefile failed"
}

src_install() {
	DESTDIR="${D}" emake install || die
}
