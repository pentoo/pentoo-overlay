# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="Generates WPA/WEP keys based on MAC and/or BSSID"
HOMEPAGE="https://routerkeygen.github.io/"

if [[ ${PV} != *9999 ]]; then
	inherit vcs-snapshot
	EGIT_COMMIT="c1f166555f6620d21b9767682dc79346806e2f5e" # 20190721
	SRC_URI="https://github.com/routerkeygen/routerkeygenPC/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	#KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/routerkeygen/routerkeygenPC"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-qt/qtscript:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dev-libs/openssl:0=
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtcore:5"

RDEPEND="${DEPEND}"
BDEPEND="dev-qt/linguist"

src_prepare() {
	sed -i \
		-e "s:DESTINATION \${ROUTERKEYGEN_DOC_DIR}:DESTINATION /usr/share/doc/${PF}:g" \
		CMakeLists.txt || die
	# This isn't the right way to do this
	sed -i 's#NetworkManager.h#libnm/NetworkManager.h#' src/wifi/QWifiManagerPrivateUnix.h || die
	#and it still fails to find glib-2.0/gio/gio.h looking for gio/gio.h

	cmake_src_prepare
}

src_compile() {
	PATH="${PATH}:/usr/lib64/qt5/bin" cmake_src_compile
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
