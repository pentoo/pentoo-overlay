# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Toggles cpu governors - loops though the available governors"
HOMEPAGE="http://pentoo.ch"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} sys-power/cpufrequtils"

S="${WORKDIR}"
src_prepare() {
	cp ""${FILESDIR}/${PN} .
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
}
