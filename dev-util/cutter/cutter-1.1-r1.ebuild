# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="A Qt and C++ GUI for radare2 reverse engineering framework"
HOMEPAGE="https://github.com/radareorg/cutter"
SRC_URI="https://github.com/radareorg/cutter/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~x86 ~arm ~amd64"

IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	>=dev-util/radare2-2.2.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"/src

src_configure() {
	eqmake5 PREFIX=/usr cutter.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
