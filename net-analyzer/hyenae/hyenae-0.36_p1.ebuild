# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MY_P=${P/_p/-}

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

src_install() {
	DESTDIR="${D}" emake install || die
}
