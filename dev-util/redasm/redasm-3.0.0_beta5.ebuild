# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="The OpenSource Disassembler"
HOMEPAGE="https://redasm.io"

#https://github.com/REDasmOrg/REDasm/issues/28
EGIT_REPO_URI="https://github.com/REDasmOrg/REDasm"
EGIT_COMMIT="v${PV/_/-}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+database"

DEPEND="dev-cpp/doctest
	dev-cpp/tbb
	dev-qt/qttest:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5"
RDEPEND="${DEPEND}
	!dev-libs/redasm-database"

#src_prepare
#sed /submodules/database /del -i CMakeLists.txt

src_prepare(){
	eapply ${FILESDIR}/doctest.patch
	cmake_src_prepare
}
