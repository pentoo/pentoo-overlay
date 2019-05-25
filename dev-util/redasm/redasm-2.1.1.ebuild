# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="The OpenSource Disassembler "
HOMEPAGE="http://redasm.io"
EGIT_REPO_URI="https://github.com/REDasmOrg/REDasm.git v${PV}"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '/set(CMAKE_INSTALL_RPATH ".")/d' CMakeLists.txt || die "sed failed"
	cmake-utils_src_prepare
#	eapply_user
}

src_install() {
	dolib.so "${BUILD_DIR}"/LibREDasm.so
	newbin "${BUILD_DIR}"/REDasm redasm
}
