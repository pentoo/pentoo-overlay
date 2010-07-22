# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Perl script which scans cisco routers for common vulnerabilities."
HOMEPAGE="http://www.scrypt.net/~g0ne"
SRC_URI="http://www.packetstormsecurity.org/cisco/CiscoAuditingTool-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Net-SNMP
	dev-perl/Net-Telnet"

S="${WORKDIR}"/CiscoAuditingTool

src_install() {
	insinto /usr/share/${PN}/lists
	doins lists/* || die
	insinto /usr/share/${PN}/plugins
	doins plugins/* || die
	insinto /usr/share/${PN}/
	doins CAT || die
	dobin "${FILESDIR}"/CAT || die
}

