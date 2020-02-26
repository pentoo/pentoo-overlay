# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Cyber Attack Management for Metasploit"
HOMEPAGE="http://www.fastandeasyhacking.com/"
MY_COMMIT="c8ca6c00b5584444ef3c3a8e32341f43974567bd"
SRC_URI="https://github.com/rsmudge/armitage/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="net-analyzer/metasploit:*
	net-analyzer/nmap"

JGRAPHX_SLOT="2.1"
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

S="${WORKDIR}/${PN}-${MY_COMMIT}"

JAVA_GENTOO_CLASSPATH="sleep,jgraphx-${JGRAPHX_SLOT},msgpack-${MSGPACK_SLOT},jdbc-postgresql,javassist-3"

#copied from kali, but not tested
#PATCHES=( "${FILESDIR}/meterpreter.patch" )

#src_prepare() {
#	find . -name '*.jar' -delete
#	cd "${S}"/lib
#	java-pkg_jar-from sleep
#	java-pkg_jar-from jgraphx-${JGRAPHX_SLOT}
#	java-pkg_jar-from msgpack-${MSGPACK_SLOT} msgpack.jar msgpack-0.6.12-devel.jar
#	java-pkg_jar-from jdbc-postgresql jdbc-postgresql.jar postgresql-9.1-901.jdbc4.jar
#	java-pkg_jar-from javassist-3 javassist.jar javassist-3.15.0-GA.jar
#	eapply_user
#}

src_install() {
	java-pkg_newjar ${PN}.jar
	java-pkg_dolauncher ${PN}
	dosbin release/armitage-unix/teamserver
	doicon release/armitage-unix/${PN}-logo.png
	dodoc release/armitage-unix/readme.txt
}
