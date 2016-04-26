# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils versionator java-pkg-2 java-ant-2

DESCRIPTION="Duct Tape for the Java platform"
HOMEPAGE="http://sleep.dashnine.org/"
SRC_URI="http://sleep.dashnine.org/download/sleep$(delete_version_separator)-lgpl.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

CDEPEND="dev-java/jsr223:0"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

S="${WORKDIR}/${PN}"

src_prepare() {
	find . -name '*.jar' -delete
	java-pkg_jar-from jsr223 jsr223.jar jsr223/sleep-engine.jar
}

src_install() {
	java-pkg_newjar ${PN}.jar
}
