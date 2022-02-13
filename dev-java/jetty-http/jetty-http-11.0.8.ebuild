# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Jetty HTTP"
HOMEPAGE="http://www.eclipse.org/jetty/"
SRC_URI="https://repo1.maven.org/maven2/org/eclipse/jetty/${PN}/${PV}/${P}-sources.jar"
LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/slf4j-api:0
	dev-java/jetty-util:0
	dev-java/jetty-io:0
"
RDEPEND=">=virtual/jre-11:*
	${CDEPEND}"
DEPEND=">=virtual/jdk-11:*
	${CDEPEND}"

JAVA_GENTOO_CLASSPATH="slf4j-api,jetty-util,jetty-io"

src_prepare(){
	rm module-info.java
	eapply_user
}
