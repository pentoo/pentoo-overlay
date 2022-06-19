# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple java-utils-2

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cli"
SRC_URI="https://github.com/kwart/jd-cli/archive/refs/tags/jd-cli-${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

#https://github.com/intoolswetrust/jd-cli/issues/81
#<=dev-java/jcommander-1.32
CDEPEND="!dev-util/jd-cli-bin
	~dev-java/jcommander-1.32
	dev-java/slf4j-api:0
	dev-java/logback-core:0
	dev-java/logback-classic:0
	dev-java/jd-lib:0
	"

RDEPEND="${CDEPEND}
	virtual/jre:11"
DEPEND="${CDEPEND}
	virtual/jdk:11"

S="${WORKDIR}/${PN}-${P}"

JAVA_GENTOO_CLASSPATH="jcommander,slf4j-api,logback-core,logback-classic,jd-lib"

JAVA_SRC_DIR="jd-cli/src/main/java/com/github/kwart/jd/cli"
JAVA_LAUNCHER_FILENAME=${PN}
JAVA_MAIN_CLASS="com.github.kwart.jd.cli.Main"
