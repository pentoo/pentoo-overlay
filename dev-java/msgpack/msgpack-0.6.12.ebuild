# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="MessagePack for Java is a binary-based efficient object serialization library in Java."
HOMEPAGE="http://msgpack.org"
SRC_URI="https://github.com/msgpack/msgpack-java/archive/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 2-3)"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

JAVASSIST_SLOT="3"

CDEPEND="dev-java/javassist:${JAVASSIST_SLOT}
	dev-java/json-simple:0
	dev-java/slf4j-api:0
	dev-java/junit:4
	dev-java/hamcrest-core:1.3
"

DEPEND="${CDEPEND}
        >=virtual/jdk-1.6"

RDEPEND="${CDEPEND}
         >=virtual/jre-1.6"

S="${WORKDIR}/${PN}-java-${P}"

JAVA_GENTOO_CLASSPATH="javassist-${JAVASSIST_SLOT},json-simple,slf4j-api,junit-4,hamcrest-core-1.3"
