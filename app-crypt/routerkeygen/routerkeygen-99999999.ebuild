# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg-utils

DESCRIPTION="Generates WPA/WEP keys based on MAC and/or BSSID"
HOMEPAGE="https://routerkeygen.github.io/"

EGIT_REPO_URI="https://github.com/routerkeygen/routerkeygenPC"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="c1f166555f6620d21b9767682dc79346806e2f5e" # 20190721
	KEYWORDS="~amd64 ~x86"
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

	cmake_src_prepare
}

src_compile() {
	# this fails looking for NetworkManager.h which is in /usr/include/libnm/NetworkManager.h but it's looking in /usr/include/NetworkManager and I don't know why
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
