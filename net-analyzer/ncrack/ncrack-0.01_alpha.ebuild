# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="highspeed network authentication cracker"
HOMEPAGE="http://nmap.org/ncrack"
SRC_URI="http://nmap.org/ncrack/dist/$PN-0.01ALPHA.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/$PN

src_install() {
	sed -i "s|DESTDIR =|DESTDIR = $D|g" Makefile || die 'sed failed'
	DESTDIR="${D}" emake install || die 'install failed'
}
