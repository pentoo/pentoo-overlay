# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="recaf"

DESCRIPTION="A modern Java bytecode editor"
HOMEPAGE="https://col-e.github.io/Recaf/"
SRC_URI="javafx? ( https://github.com/Col-E/Recaf/releases/download/${PV}/${MY_PN}-${PV}.jar )
	!javafx? ( https://dev.pentoo.ch/~blshkv/distfiles/${MY_PN}-${PV}-patched.jar )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="javafx"

#might work with oracle/javafx using https://gluonhq.com/products/javafx/
RDEPEND="|| ( virtual/jre:* virtual/jdk:* )
	javafx? ( dev-java/openjdk[javafx?] ) "
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/${MY_PN}.jar" || die
}

src_install() {
	insinto "/opt/${MY_PN}/"
	doins "${MY_PN}.jar"

	newbin - ${MY_PN} <<-EOF
		java -jar /opt/recaf/recaf.jar
	EOF

}
