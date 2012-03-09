# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-1.5-r1.ebuild,v 1.2 2010/09/25 15:18:56 eva Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A plugin for IDA Pro designed to provide collaborative reverse engineering"
HOMEPAGE="http://www.idabook.com/collabreate/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#IUSE="+mysql"
IUSE="mysql +postgres"

RDEPEND="virtual/jdk
	 mysql? ( dev-db/mysql
		  dev-java/jdbc-mysql )
	 postgres? ( dev-db/postgresql-server
		     dev-java/jdbc-postgresql )"

DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}/trunk"

src_configure() {
	cd "${S}"
	epatch "${FILESDIR}/mysql-deterministic-${PV}.patch"
}

src_compile() {
	cd "${S}"/"${PN}"/server
	use mysql && [ -e /usr/share/jdbc-mysql/lib/jdbc-mysql.jar ] && cp /usr/share/jdbc-mysql/lib/jdbc-mysql.jar ./
	use postgres && [ -e /usr/share/jdbc-postgresql/lib/jdbc-postgresql.jar ] && cp /usr/share/jdbc-postgresql/lib/jdbc-postgresql.jar ./
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
	if use postgres; then
		elog "For postgresql, you need to create a user and a db for collabreate"
		elog "go in /opt/collabreate/server and do the following:"
		elog "su postgres"
		elog "createuser -s -d -R collab"
		elog "createdb -U collab collabDB"
		elog "psql -q -U collab -d collabDB -f dbschema.sql"
		elog "now edit your server.conf and setup collabreate"
	fi
}
