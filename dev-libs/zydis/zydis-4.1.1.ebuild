# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fast and lightweight x86/x86-64 disassembler and code generation library"
HOMEPAGE="https://zydis.re"
SRC_URI="https://github.com/zyantific/zydis/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc man test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/zycore-c
"
DEPEND="${RDEPEND}"
BDEPEND="
	doc? ( app-text/doxygen )
	man? ( app-text/ronn-ng )
"

PATCHES=(
	"${FILESDIR}/${PN}-4.1.1-bump-minimum-required-CMake-version.patch"
)

src_configure() {
	local mycmakeargs=(
		-DZYAN_SYSTEM_ZYCORE=yes
		-DZYDIS_BUILD_EXAMPLES=no
		-DZYDIS_BUILD_SHARED_LIB=yes

		-DZYDIS_BUILD_DOXYGEN=$(usex doc)
		-DZYDIS_BUILD_MAN=$(usex man)
		-DZYDIS_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
