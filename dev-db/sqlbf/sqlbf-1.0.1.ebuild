# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlbf/sqlbf-1.0.1.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI=5

inherit eutils

DESCRIPTION="SQLBF is a tool to audit mssql passwords strength offline"
HOMEPAGE="http://www.cqure.net/wp/sqlpat/"
SRC_URI="http://www.cqure.net/tools/${PN}-all-src-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-libs/openssl"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}/${P}"-make.patch
}

src_install () {
	dobin bin/sqlbf
	dodoc README.wri
	docinto sample
	dodoc default.cm hashes.txt small.dic
}
