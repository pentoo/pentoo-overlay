# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Duct Tape for the Java platform"
HOMEPAGE="http://sleep.dashnine.org/"
SRC_URI="http://sleep.dashnine.org/download/sleep${PV//\./}-lgpl.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

CDEPEND="dev-java/jsr223:0"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	find . -name '*.jar' -delete
	java-pkg_jar-from jsr223 jsr223.jar jsr223/sleep-engine.jar
}

src_install() {
	java-pkg_newjar ${PN}.jar
}
