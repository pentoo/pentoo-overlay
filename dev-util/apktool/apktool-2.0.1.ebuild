# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A tool for reengineering 3rd party, closed, binary Android apps."
HOMEPAGE="http://ibotpeaches.github.io/Apktool/"
SRC_URI="https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.0.1.jar -> ${P}.jar"
LICENSE="Apache 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=virtual/jre-1.7 >=virtual/jdk-1.7 )
	dev-util/android-sdk-update-manager"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${A}" "${WORKDIR}/${PN}.jar"
}

src_install() {
	exeinto /usr/bin
	doexe ${FILESDIR}/apktool
	insinto /opt/${PN}/
	doins apktool.jar
}
