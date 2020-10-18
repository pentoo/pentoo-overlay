# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The reliable, generic, fast and flexible logging framework"
HOMEPAGE="https://github.com/qos-ch/logback"
#SRC_URI="https://github.com/qos-ch/logback/archive/v_${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/qos-ch/logback/archive/v_1.3.0-alpha5.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#WIP
#KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/jre:11"
DEPEND="${RDEPEND}
	dev-java/slf4j-api
	dev-java/slf4j-log4j12
	dev-java/junit:4
	dev-java/osgi-core-api
	virtual/jdk:11"

JAVA_GENTOO_CLASSPATH="slf4j-api,slf4j-log4j12,junit-4,osgi-core-api"

#fails to compile:
#logback-classic/src/main/java9/module-info.java:1: error: too many module declarations found
