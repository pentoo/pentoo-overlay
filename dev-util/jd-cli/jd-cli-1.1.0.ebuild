# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cli"
SRC_URI="https://github.com/kwart/jd-cli/archive/jd-cmd-${PV}.Final.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
#logback fails to build
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre:11"
DEPEND="${RDEPEND}
	virtual/jdk:11
	dev-java/jcommander
	dev-java/slf4j-api
	dev-java/logback"

S="${WORKDIR}/${PN}-${P}.Final"

JAVA_GENTOO_CLASSPATH="jcommander,slf4j-api,logback"

JAVA_SRC_DIR="jd-cli/src/main/java/com/github/kwart/jd/cli"

JAVA_LAUNCHER_FILENAME=${PN}
JAVA_MAIN_CLASS="com.github.kwart.jd.cli.Main"
