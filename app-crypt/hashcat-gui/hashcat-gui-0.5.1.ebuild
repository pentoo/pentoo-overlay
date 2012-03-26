# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils qt4-r2

#pax-utils?

DESCRIPTION="A gui for the *hashcat* suite of tools"
HOMEPAGE="https://github.com/scandium/hashcat-gui"
#HOMEPAGE="http://hashcat.net/hashcat-gui/"

SRC_URI="https://github.com/scandium/hashcat-gui/zipball/b6b01be723742ad89ba31fdb2c30b35306318f8b -> ${P}.zip"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND="app-crypt/hashcat-bin
	app-crypt/oclhashcat-plus-bin
	app-crypt/oclhashcat-lite-bin
	app-arch/bzip2
	sys-libs/zlib
	sys-apps/util-linux
	media-libs/fontconfig
	media-libs/libpng
	media-libs/freetype
	x11-libs/libSM
	x11-libs/libXrender
	x11-libs/libXinerama
	x11-libs/libXau
	x11-libs/qt-gui
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/qt-core
	x11-libs/libXdmcp
	x11-libs/libxcb
	x11-libs/libICE
	dev-libs/glib
	dev-libs/expat
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/scandium-hashcat-gui-b6b01be

src_prepare() {
	sed -i 's#./hashcat#/opt/hashcat-bin#g' src/mainwindow.cpp
	sed -i 's#./oclHashcat-plus#/opt/oclhashcat-plus-bin#g' src/mainwindow.cpp
	sed -i 's#./oclHashcat-lite#/opt/oclhashcat-lite-bin#g' src/mainwindow.cpp
}

src_install() {
        dodoc ChangeLog FAQ INSTALL LICENSE README TODO

	cd src
	eqmake4 -config release
	emake

	#I assume this is needed but I didn't check
	#pax-mark m hashcat-gui

	dobin hashcat-gui
}
