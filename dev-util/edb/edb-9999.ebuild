# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="edb is a cross platform x86/x86-64 debugger, inspired by Ollydbg"
HOMEPAGE="https://github.com/eteran/edb-debugger"

LICENSE="GPL-2"
IUSE="debug graphviz"
SLOT="0"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/eteran/edb-debugger.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/eteran/edb-debugger/releases/download/${PV}/edb-debugger-${PV}.tgz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/edb-debugger-${PV}
fi

RDEPEND="
	>=dev-libs/capstone-3.0
	graphviz? ( >=media-gfx/graphviz-2.38.0 )
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5
	dev-qt/qtnetwork:5
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	"
DEPEND="
	>=dev-libs/boost-1.35.0
	${RDEPEND}"

src_prepare(){
	if ! use graphviz; then
		sed -i '/pkg_check_modules(GRAPHVIZ/d' CMakeLists.txt
	fi
	eapply_user
}

src_configure() {
	CMAKE_BUILD_TYPE=Release
	use debug && CMAKE_BUILD_TYPE=Debug

	mycmakeargs+=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DQT_VERSION=Qt5
	)

	cmake-utils_src_configure
}
