# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="A tool for reengineering 3rd party, closed, binary Android apps."
HOMEPAGE="http://code.google.com/p/android-apktool/"
SRC_URI="http://android-${PN}.googlecode.com/files/${PN}${PV}.tar.bz2
	http://android-${PN}.googlecode.com/files/${PN}-install-linux-r05-ibot.tar.bz2"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/android-sdk-update-manager"

src_prepare() {
	mv "${S}"/apktool-install-linux-r05-ibot/* "${S}"
	epatch "$FILESDIR"/apktool.patch
}

src_install() {
	exeinto /usr/bin
	doexe apktool
	doexe aapt
	insinto /opt/${PN}/
	doins ${PN}${PV}/apktool.jar
}
