# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="MessagePack for Java is a binary-based efficient object serialization library"
HOMEPAGE="http://msgpack.org"
SRC_URI="https://codeload.github.com/${PN}/${PN}/tar.gz/java-${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="$(ver_cut 2-3)"
KEYWORDS="~amd64 ~x86"
IUSE=""

JAVASSIST_SLOT="3"

CDEPEND="dev-java/javassist:${JAVASSIST_SLOT}
	dev-java/json-simple
	dev-java/slf4j-api"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

S="${WORKDIR}/${PN}-java-${PV}/java/src/main"

JAVA_GENTOO_CLASSPATH="javassist-${JAVASSIST_SLOT},json-simple,slf4j-api"
