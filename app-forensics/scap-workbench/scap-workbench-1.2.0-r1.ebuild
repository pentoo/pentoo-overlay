# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils xdg-utils

DESCRIPTION="SCAP Scanner And Tailoring Graphical User Interface"
HOMEPAGE="http://www.open-scap.org https://github.com/OpenSCAP/scap-workbench"
SRC_URI="https://github.com/OpenSCAP/scap-workbench/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="policykit"

RDEPEND="
	app-forensics/openscap
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

DEPEND="${RDEPEND}
	app-text/asciidoc
	virtual/pkgconfig"

src_prepare() {
	eapply "${FILESDIR}"/${P}_replace_asciidoctor_by_asciidoc.diff
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR="/usr/share/doc/${P}"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
