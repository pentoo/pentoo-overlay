# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-1.5-r1.ebuild,v 1.2 2010/09/25 15:18:56 eva Exp $

EAPI="2"

inherit subversion

DESCRIPTION="A plugin for IDA Pro designed to provide collaborative reverse engineering"
HOMEPAGE="http://www.idabook.com/collabreate/"
ESVN_REPO_URI="https://collabreate.svn.sourceforge.net/svnroot/collabreate/trunk@13"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#IUSE="+mysql"
IUSE=""

RDEPEND="virtual/jdk
	 dev-db/postgresql-server
	 dev-java/jdbc-postgresql"

DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}/trunk"

src_compile() {
	cd "${S}"/"${PN}"/server
	cp /usr/share/jdbc-postgresql/lib/jdbc-postgresql.jar ./ || die "jdbc-postgresql.jar not found!!!"
	sh build_jar.sh* || die 'failed to build server'
}

src_install() {
	cd "${S}"/"${PN}"/server
	dodir /opt/collabreate/server
	insinto /opt/collabreate/server
	doins *.jar
	doins *.conf
	doins *.sql
	doins launch_*
	dodoc README
}

pkg_postinst() {
	elog "Read the readme file in the doc dir"
	elog "For postgresql, you need to create a user and a db for collabreate"
	elog "go in /opt/collabreate/server and do the following:"
	elog "su postgres"
	elog "createuser -s -d -R collab"
	elog "createdb -U collab collabDB"
	elog "Launch postgresql client"
	elog "psql"
	elog "ALTER DATABASE \"collabDB\" SET escape_string_warning=off;"
	elog "ALTER DATABASE \"collabDB\" SET standard_conforming_strings=off;"
	elog "\q"
	elog "Then import the schema"
	elog "psql -q -U collab -d collabDB -f dbschema.sql"
	elog "now edit your server.conf and setup collabreate"
}
