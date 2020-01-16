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
IUSE="system-javafx"

RDEPEND="|| ( virtual/jre virtual/jdk )
	system-javafx? (
		|| ( dev-java/openjfx dev-java/oracle-jdk-bin[javafx] ) 
	) "
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/${MY_PN}.jar" || die
}

src_install() {
	insinto "/opt/${MY_PN}/"
	doins "${MY_PN}.jar"
	dobin "${FILESDIR}/${MY_PN}"
}
