# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils xdg-utils

DESCRIPTION="SCAP Scanner And Tailoring Graphical User Interface"
HOMEPAGE="http://www.open-scap.org https://github.com/OpenSCAP/scap-workbench"
SRC_URI="https://github.com/OpenSCAP/scap-workbench/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="policykit"

BDEPEND="
	app-text/asciidoc
	virtual/pkgconfig"
RDEPEND="
	<=app-forensics/openscap-1.3.1
	app-forensics/scap-security-guide
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5[png]
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5
	dev-libs/libxslt
	policykit? ( sys-auth/polkit )
	virtual/ssh
	x11-libs/libxcb"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "/set(CMAKE_CXX_FLAGS/s|-Werror||g" CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( -DCMAKE_INSTALL_DOCDIR="/usr/share/doc/${P}" )
	cmake_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
