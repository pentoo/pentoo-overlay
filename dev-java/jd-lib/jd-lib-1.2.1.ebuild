# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cli"
SRC_URI="https://github.com/kwart/jd-cli/archive/refs/tags/jd-cli-${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

CDEPEND="dev-java/jcommander:0
	dev-java/slf4j-api:0
	dev-java/logback-core:0
	
	dev-java/jd-core:0
	"

RDEPEND="${CDEPEND}
	virtual/jre:11"
DEPEND="${CDEPEND}
	virtual/jdk:11"

S="${WORKDIR}/jd-cli-jd-cli-${PV}"

JAVA_GENTOO_CLASSPATH="jcommander,slf4j-api,logback-core,jd-core"

#JAVA_SRC_DIR="jd-cli/src/main/java/com/github/kwart/jd/cli"
#JAVA_LAUNCHER_FILENAME=${PN}
#JAVA_MAIN_CLASS="com.github.kwart.jd.cli.Main"

JAVA_SRC_DIR="jd-lib/src/main/java/com/github/kwart/jd"
