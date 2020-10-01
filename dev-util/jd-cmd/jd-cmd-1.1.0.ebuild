# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cmd/"
SRC_URI="https://github.com/kwart/jd-cmd/archive/${P}.Final.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre:11"
DEPEND="${RDEPEND}
	dev-java/jcommander
	dev-java/slf4j-api
	virtual/jdk:11"

S="${WORKDIR}/${PN}-${P}.Final"

JAVA_GENTOO_CLASSPATH="jcommander,slf4j-api"

JAVA_SRC_DIR="jd-cli/src/main/java/com/github/kwart/jd/cli"

JAVA_LAUNCHER_FILENAME=${PN}
JAVA_MAIN_CLASS="com.github.kwart.jd.cli.Main"
