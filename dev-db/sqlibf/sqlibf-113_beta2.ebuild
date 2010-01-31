# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlbf/sqlbf-1.0.1.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

MY_P="${PN}${PV/_beta/b}"
DESCRIPTION="Tool for automatizing the work of detecting and exploiting SQL Injection vulnerabilities"
HOMEPAGE="http://www.open-labs.org/"
SRC_URI="http://www.open-labs.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_install () {
	dobin sqlibf
	dodoc README.txt todo.txt
}
