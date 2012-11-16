# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Toggles touchpads on/off. Supports Synaptics and Elantech touchpads"
HOMEPAGE="http://pentoo.ch"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
# todo: find out what happens when both are installed
RDEPEND="${DEPEND} || (
	x11-drivers/xf86-input-synaptics
	x11-apps/xinput	)"

S="${WORKDIR}"
src_prepare() {
	cp ""${FILESDIR}/${PN} .
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
}
