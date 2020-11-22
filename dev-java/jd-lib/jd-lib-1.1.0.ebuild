# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cmd/"
SRC_URI="https://github.com/kwart/jd-cmd/archive/jd-cmd-${PV}.Final.tar.gz -> jd-cmd-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre:11"
DEPEND="${RDEPEND}
	dev-java/jcommander
	dev-java/slf4j-api
	dev-java/hamcrest-core:1.3
	dev-java/junit:4
	dev-java/jd-core
	virtual/jdk:11"

S="${WORKDIR}/jd-cmd-jd-cmd-${PV}.Final"

JAVA_GENTOO_CLASSPATH="jcommander,slf4j-api,hamcrest-core-1.3,junit-4,jd-core"
