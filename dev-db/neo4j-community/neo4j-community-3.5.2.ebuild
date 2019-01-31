# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Neo4j is a high-performance, NOSQL graph database with all the features of a mature and robust database."
HOMEPAGE="https://neo4j.org/"
SRC_URI="https://dist.neo4j.org/${PN}-${PV}-unix.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#need to adjust patches
#KEYWORDS="amd64 ~x86"

RDEPEND="!dev-db/neo4j-advanced
	!dev-db/neo4j-enterprise
	>=virtual/jre-1.6
	sys-process/lsof"

#src_prepare() {
#	epatch "${FILESDIR}/${PN}-1.7-neo4j.patch"
#	epatch "${FILESDIR}/${PN}-1.7-utils.patch"
#	epatch "${FILESDIR}/${PN}-1.7-wrapper_configuration.patch"
#	epatch "${FILESDIR}/${PN}-1.7-server_properties.patch"
#}

src_install() {
	exeinto /opt/neo4j/bin
	doexe "${S}"/bin/neo4j
	doexe "${S}"/bin/neo4j-shell
	doexe "${S}"/bin/utils

	# system requirements
	insinto /opt/neo4j/system/lib
	doins "${S}"/system/lib/*.jar
	
	# components directory
	insinto /opt/neo4j/lib
	doins "${S}"/lib/*.jar

	# plugins directory
	dodir /opt/neo4j/plugins

	# config files
	insinto /etc/neo4j
	doins "${S}"/conf/neo4j-wrapper.conf
	doins "${S}"/conf/neo4j.properties
	doins "${S}"/conf/neo4j-server.properties
	doins "${S}"/conf/logging.properties

	# data directories
	dodir /var/db/neo4j
	dodir /var/db/neo4j/log

	# documentation
	dodoc "${S}"/*.txt
	dodoc -r "${S}"/doc/*

	# init script
	newinitd "${FILESDIR}"/neo4j.init neo4j

	# create symlinks
	dosym /opt/neo4j/bin/neo4j /opt/bin/neo4j || die
	dosym /opt/neo4j/bin/neo4j-shell /opt/bin/neo4j-shell
}
