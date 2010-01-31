# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlat/sqlat-1.1.0.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI="2"

inherit eutils
DESCRIPTION="A small multi-threaded tool that scans for Microsoft SQL Servers"
HOMEPAGE="http://www.cqure.net/wp/mssqlscan"
SRC_URI="http://www.cqure.net/tools/${PN}-bin-0_8_4.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/MSSQLScan

RDEPEND="virtual/jre"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-path.patch"
}
src_compile(){
	einfo "Nothing to compile"
}
src_install () {
	# dodir /usr/lib/"${PN}"
	insinto /usr/lib/"${PN}"
	doins -r bin lib
	newbin mssqlscan.sh mssqlscan
}
