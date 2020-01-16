# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Skeleton command:
# java-ebuilder --generate-ebuild --workdir . --pom . --download-uri https://github.com/Col-E/Recaf/archive/1.15.9.tar.gz --slot 0 --keywords "~amd64" --ebuild recaf-1.15.9.ebuild

EAPI=7

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A modern java bytecode editor"
HOMEPAGE="https://github.com/Col-E/Recaf/"
SRC_URI="https://github.com/Col-E/Recaf/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE=""
SLOT="0"
#KEYWORDS="~amd64"
MAVEN_ID="me.coley:recaf:1.15.8"

# Common dependencies
# POM: .
# com.atlassian.commonmark:commonmark:0.12.1 -> !!!groupId-not-found!!!
# com.eclipsesource.minimal-json:minimal-json:0.9.5 -> !!!groupId-not-found!!!
# com.github.Col-E:Events:1.4.1 -> !!!groupId-not-found!!!
# com.github.Col-E:Simple-Memory-Compiler:2.1 -> !!!groupId-not-found!!!
# com.github.Col-E:logging:1.0 -> !!!groupId-not-found!!!
# com.github.javaparser:javaparser-core:3.14.4 -> !!!groupId-not-found!!!
# com.github.olivergondza:maven-jdk-tools-wrapper:0.1 -> !!!groupId-not-found!!!
# com.google.guava:guava:28.0-jre -> !!!groupId-not-found!!!
# info.picocli:picocli:4.0.0-beta-2 -> !!!groupId-not-found!!!
# net.sourceforge.jregex:jregex:1.2_01 -> !!!groupId-not-found!!!
# org.benf:cfr:0.146 -> !!!groupId-not-found!!!
# org.controlsfx:controlsfx:11.0.0 -> !!!groupId-not-found!!!
# org.fxmisc.richtext:richtextfx:0.10.1 -> !!!groupId-not-found!!!
# org.openjfx:javafx-web:11 -> !!!groupId-not-found!!!
# org.ow2.asm:asm:7.1 -> !!!groupId-not-found!!!
# org.ow2.asm:asm-analysis:7.1 -> !!!groupId-not-found!!!
# org.ow2.asm:asm-commons:7.1 -> !!!groupId-not-found!!!
# org.ow2.asm:asm-tree:7.1 -> !!!groupId-not-found!!!
# org.ow2.asm:asm-util:7.1 -> !!!groupId-not-found!!!
# org.plugface:plugface-core:0.7.1 -> !!!groupId-not-found!!!
# org.slf4j:slf4j-simple:1.7.21 -> !!!groupId-not-found!!!

#CDEPEND="
#	!!!groupId-not-found!!!
#"

# Compile dependencies
# POM: .
# test? org.hamcrest:hamcrest:2.1 -> !!!groupId-not-found!!!
# test? org.junit.jupiter:junit-jupiter-api:5.4.2 -> !!!groupId-not-found!!!
# test? org.junit.jupiter:junit-jupiter-engine:5.4.2 -> !!!groupId-not-found!!!
# test? org.junit.jupiter:junit-jupiter-params:5.4.2 -> !!!groupId-not-found!!!
# test? org.junit.platform:junit-platform-surefire-provider:1.3.2 -> !!!groupId-not-found!!!
# test? org.openjfx:javafx-swing:11 -> !!!groupId-not-found!!!

DEPEND="
	=virtual/jdk-1.8:*
	${CDEPEND}"
#	test? (
#		!!!groupId-not-found!!!
#	)
#"

RDEPEND="
	>=virtual/jre-1.8:*
${CDEPEND}"

S="${WORKDIR}"

#JAVA_GENTOO_CLASSPATH="!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!"
JAVA_SRC_DIR="src/main/java"
JAVA_RESOURCE_DIRS=(
	"src/main/resources"
)

#JAVA_GENTOO_TEST_CLASSPATH="!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!,!!!groupId-not-found!!!"
JAVA_TEST_SRC_DIR="src/test/java"
JAVA_TEST_RESOURCE_DIRS=(
	"src/test/resources"
)
