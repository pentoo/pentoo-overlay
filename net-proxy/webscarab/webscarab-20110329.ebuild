# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/webscarab/webscarab-20070504.ebuild,v 1.1 2007/06/17 16:14:46 mrness Exp $

EAPI=3

DESCRIPTION="A framework for analysing applications that communicate using the HTTP and HTTPS protocols"
HOMEPAGE="http://www.owasp.org/software/webscarab.html"
#SRC_URI="mirror://sourceforge/owasp/${PN}-selfcontained-${PV}-1631.jar"
SRC_URI="http://dawes.za.net/rogan/webscarab/${PN}-one-${PV}-1330.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )"

src_unpack() {
	: # Nothing to unpack
}

src_install() {
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	newbin "${FILESDIR}/${PN}-lite.sh" "${PN}-lite"
	insinto /usr/lib
	newins "${DISTDIR}/${A}" "${PN}.jar"
}

pkg_postinst() {
	elog "You can enable the advanced interface in Tools->Full-featured-interface"
	elog "Run webscarab-lite for the lite version after that"
}
