# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="The OpenSource Disassembler"
HOMEPAGE="https://redasm.io"

EGIT_REPO_URI="https://github.com/REDasmOrg/REDasm"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+database"

DEPEND="
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5"
RDEPEND="${DEPEND}
	database? ( dev-libs/redasm-database )"

src_prepare() {
	sed -i '/set(CMAKE_INSTALL_RPATH ".")/d' CMakeLists.txt || die "sed failed"
	#fix database path
	sed -i 's|QDir::currentPath().toStdString()|"/usr/share/redasm/"|g' mainwindow.cpp || die "sed 2 failed"
	sed -i 's|QDir::currentPath().toStdString()|"/usr/share/redasm/"|g' unittest/disassemblertest.cpp || die "sed 3 failed"

	cmake_src_prepare
}

src_install() {
	dolib.so "${BUILD_DIR}"/LibREDasm.so
	newbin "${BUILD_DIR}"/REDasm redasm
}
