# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A tool for reengineering 3rd party, closed, binary Android apps."
HOMEPAGE="http://code.google.com/p/android-apktool/"
SRC_URI="http://connortumbleson.com/apktool/test_versions/apktool_2.0.0b9.jar?ref=blog-post -> apktool_2.0.0b9.jar"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
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
