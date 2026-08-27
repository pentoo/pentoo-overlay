# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Zyan Core Library for C"
HOMEPAGE="https://github.com/zyantific/zycore-c"
SRC_URI="https://github.com/zyantific/zycore-c/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND="
	doc? ( app-text/doxygen )
	test? ( dev-cpp/gtest )
"

PATCHES=(
	"${FILESDIR}/${PN}-1.5.2-build-documentation-only-when-requested.patch"
	"${FILESDIR}/${PN}-1.5.2-bump-minimum-required-CMake-version.patch"
)

src_configure() {
	local mycmakeargs=(
		-DZYCORE_BUILD_SHARED_LIB=yes

		-DZYCORE_BUILD_DOCS=$(usex doc)
		-DZYCORE_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
