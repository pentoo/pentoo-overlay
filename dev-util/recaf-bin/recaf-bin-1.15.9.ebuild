# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="recaf"

DESCRIPTION="A modern Java bytecode editor"
HOMEPAGE="https://col-e.github.io/Recaf/"
SRC_URI="https://github.com/Col-E/Recaf/releases/download/${PV}/${MY_PN}-${PV}.jar -> ${MY_PN}-${PV}.jar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="javafx"

#might work with oracle/javafx using https://gluonhq.com/products/javafx/
RDEPEND="|| ( virtual/jre virtual/jdk:* )
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
		jarpath="/opt/recaf/recaf.jar"
		javaOpts="-Xmx512M -Dfile.encoding=utf-8"
		java $javaOpts -jar "$jarpath" "$@"
	EOF
}
