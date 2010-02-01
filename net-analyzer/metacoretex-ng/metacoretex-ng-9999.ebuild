# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/metacoretex-ng/metacoretex-ng-9999.ebuild,v 1.1.1.1 2006/03/20 21:30:18 grimmlin Exp $

inherit cvs

DESCRIPTION="A nice, java-based, MYSQL/Oracle/MSSQL/ODBC attack framework"
HOMEPAGE="http://metacoretex-ng.sourceforge.net"

ECVS_SERVER="metacoretex-ng.cvs.sourceforge.net:/cvsroot/metacoretex-ng/"
ECVS_MODULE="MetaCoreTex-NG"
ECVS_LOCALNAME="${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-java/ant"
RDEPEND="virtual/jre"

src_compile() {
	ant probes
}

src_install() {
	find ./ -name CVS | xargs rm -rf
	dodoc -r license readme todo docs/*
	insinto /opt/${PN}/
	doins -r conf/ contrib/ dist/ html/ probes/ schema/ test/ *.txt *.xsl *.xml
	newsbin "${FILESDIR}"/mctx.sh mctx
}

pkg_postinst() {
	ewarn
	ewarn "This is a CVS ebuild - Any bugs reported to Gentoo will be marked INVALID"
	ewarn
}
