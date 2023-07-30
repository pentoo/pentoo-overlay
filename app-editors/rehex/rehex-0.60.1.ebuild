# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

WX_GTK_VER="3.0-gtk3"

LUA_COMPAT=(lua5-{1..4} )
inherit wxwidgets xdg lua-single

DESCRIPTION="Reverse Engineers' Hex Editor"
HOMEPAGE="https://github.com/solemnwarning/rehex"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/solemnwarning/${PN}.git"
else
	SRC_URI="https://github.com/solemnwarning/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"
fi

RESTRICT="test"
#	!test? ( test )"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND="${LUA_DEPS}
	dev-libs/capstone
	dev-libs/jansson
	x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}"
#	test? (
#		dev-cpp/gtest
#	)"

BDEPEND="virtual/pkgconfig
	dev-lua/busted
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
