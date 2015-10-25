# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 java-pkg-2 java-ant-2

DESCRIPTION="Cyber Attack Management for Metasploit"
HOMEPAGE="http://www.fastandeasyhacking.com/"
EGIT_REPO_URI="https://github.com/rsmudge/armitage.git"
EGIT_COMMIT="b2d5b4fc80895bd5196215b39c2bec2be0b7304e"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

CDEPEND="net-analyzer/metasploit
	net-analyzer/nmap"

JGRAPHX_SLOT="1.4"
MSGPACK_SLOT="6.12"

DEPEND="${CDEPEND}
	!net-analyzer/armitage-bin
	dev-java/jgraphx:${JGRAPHX_SLOT}
	dev-java/sleep:0
	dev-java/msgpack:${MSGPACK_SLOT}
	dev-java/javassist:3
	dev-java/jdbc-postgresql:0
		>=virtual/jdk-1.6"

RDEPEND="${CDEPEND}
		 >=virtual/jre-1.6"

S="${WORKDIR}"

src_prepare() {
	find . -name '*.jar' -delete
	cd "${S}"/lib
	java-pkg_jar-from sleep
	java-pkg_jar-from jgraphx-${JGRAPHX_SLOT}
	java-pkg_jar-from msgpack-${MSGPACK_SLOT} msgpack.jar msgpack-0.6.12-devel.jar
	java-pkg_jar-from jdbc-postgresql jdbc-postgresql.jar postgresql-9.1-901.jdbc4.jar
	java-pkg_jar-from javassist-3 javassist.jar javassist-3.15.0-GA.jar
}

src_install() {
	java-pkg_newjar ${PN}.jar
	java-pkg_dolauncher ${PN}
	dosbin release/armitage-unix/teamserver
	doicon release/armitage-unix/${PN}-logo.png
	dodoc release/armitage-unix/readme.txt
}
