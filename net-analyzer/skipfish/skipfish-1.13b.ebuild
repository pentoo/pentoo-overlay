# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A fully automated, active web application security reconnaissance tool"
HOMEPAGE="http://code.google.com/p/skipfish/"
SRC_URI="http://skipfish.googlecode.com/files/${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-dns/libidn
		dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/$PN

src_prepare() {
	sed -i "s|-O3|$CFLAGS|g" Makefile || die 'sed failed'
	sed -i 's|"assets"|"/usr/share/skipfish/assets"|g' config.h || die 'sed failed'
	rm assets/COPYING
}

src_install() {
	dobin skipfish || die 'install failed'
	insinto /usr/share/skipfish
	doins -r assets
	doins -r dictionaries
	dodoc README dictionaries/README-FIRST
}

pkg_postinst() {
	elog "To run skipfish you should copy a dictionary from"
	elog "/usr/share/skipfish/dictionaries to your CWD. For further information"
	elog "check the documentation in /usr/share/doc/${P}."
}
