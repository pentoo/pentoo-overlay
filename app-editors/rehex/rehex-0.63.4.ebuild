# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"

LUA_COMPAT=( lua5-{3,4} )
inherit wxwidgets lua-single xdg

DESCRIPTION="Reverse Engineers' Hex Editor"
HOMEPAGE="https://github.com/solemnwarning/rehex"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/solemnwarning/${PN}.git"
else
	SRC_URI="https://github.com/solemnwarning/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RESTRICT="test"

RDEPEND="${LUA_DEPS}
	dev-libs/botan:*
	dev-libs/capstone
	dev-libs/jansson
	x11-libs/wxGTK:*[X]"
#	x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}"
#	test? (
#		dev-cpp/gtest
#	)"

BDEPEND="virtual/pkgconfig
	$(lua_gen_cond_dep '
		dev-lua/busted[${LUA_USEDEP}]
	')
	doc? ( dev-perl/Template-Toolkit )"

src_configure() {
	export LUA_PKG=${ELUA}
	if use !doc ; then
		export BUILD_HELP=0
	fi
	setup-wxwidgets
}

src_install() {
	emake LUA_PKG=${ELUA} prefix="${D}"/usr install
}
