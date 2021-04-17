# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The reliable, generic, fast and flexible logging framework"
HOMEPAGE="https://github.com/qos-ch/logback"
SRC_URI="https://github.com/qos-ch/logback/archive/v_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#WIP
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre:11"
DEPEND="${RDEPEND}
	dev-java/slf4j-api
	dev-java/slf4j-log4j12
	dev-java/junit:4
	dev-java/osgi-core-api
	virtual/jdk:11
	dev-java/mockito
	dev-java/janino
	dev-java/joda-time
	java-virtuals/servlet-api:3.1
	dev-java/jansi
	dev-java/oracle-javamail
	dev-java/jetty-server
	"

JAVA_GENTOO_CLASSPATH="slf4j-api,slf4j-log4j12,junit-4,osgi-core-api,joda-time,mockito,jansi-native,janino,servlet-api-3.1,oracle-javamail,jetty-server"

src_prepare(){
	rm -r ./logback-v_1.2.3/logback-classic
	rm -r ./logback-v_1.2.3/logback-access/src/test/
	eapply_user
}

#/logback-access/src/main/java/ch/qos/logback/access/jetty/RequestLogImpl.java:314: error: cannot find symbol
#    public void addLifeCycleListener(Listener listener) {
