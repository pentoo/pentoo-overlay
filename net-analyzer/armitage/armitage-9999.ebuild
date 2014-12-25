# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils subversion java-pkg-2 java-ant-2

DESCRIPTION="Cyber Attack Management for Metasploit"
HOMEPAGE="http://www.fastandeasyhacking.com/"
ESVN_REPO_URI="http://armitage.googlecode.com/svn/trunk/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

CDEPEND="net-analyzer/metasploit
	net-analyzer/nmap"

JGRAPHX_SLOT="1.4"
MSGPACK_SLOT="5.1"

DEPEND="${CDEPEND}
	!net-analyzer/armitage-bin
	dev-java/jgraphx:${JGRAPHX_SLOT}
	dev-java/sleep
	dev-java/msgpack:${MSGPACK_SLOT}
	dev-java/jdbc-postgresql
		>=virtual/jdk-1.6"

RDEPEND="${CDEPEND}
		 >=virtual/jre-1.6"

S="${WORKDIR}"

src_prepare() {
	find . -name '*.jar' -delete
	cd "${S}"/lib
	java-pkg_jar-from sleep
	java-pkg_jar-from jgraphx-${JGRAPHX_SLOT}
	java-pkg_jar-from msgpack-${MSGPACK_SLOT} msgpack.jar msgpack-0.5.1-devel.jar
	java-pkg_jar-from jdbc-postgresql jdbc-postgresql.jar postgresql-9.1-901.jdbc4.jar
}

src_install() {
	java-pkg_newjar ${PN}.jar
	java-pkg_dolauncher ${PN}
	dosbin release/armitage-unix/teamserver
	doicon release/armitage-unix/${PN}-logo.png
	dodoc release/armitage-unix/readme.txt
}
