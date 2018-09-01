# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="MessagePack for Java is a binary-based efficient object serialization library"
HOMEPAGE="http://msgpack.org"
SRC_URI="https://github.com/msgpack/msgpack-java/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 2-3)"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/junit:4
	dev-java/hamcrest-core:1.3
	dev-java/jackson:2
	dev-java/jackson-databind:2
	dev-java/jackson-annotations:2
	dev-java/commons-math:3
"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.7"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.7"

S="${WORKDIR}/${PN}-java-${PV}"

JAVA_GENTOO_CLASSPATH="junit-4,hamcrest-core-1.3,jackson-2,jackson-databind-2,jackson-annotations-2,commons-math-3"
