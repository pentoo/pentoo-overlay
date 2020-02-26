# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit eutils desktop python-single-r1 qmake-utils xdg-utils

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey NEO"
HOMEPAGE="https://developers.yubico.com/yubioath-desktop/ https://github.com/Yubico/yubioath-desktop"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Yubico/yubioath-desktop"
else
	SRC_URI="https://github.com/Yubico/yubioath-desktop/archive/${P}.tar.gz"

	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${P}"
fi

SLOT="0"
LICENSE="BSD-2"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtdeclarative:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	x11-libs/libdrm"

RDEPEND="${DEPEND}
	$(python_gen_cond_dep '>=app-crypt/yubikey-manager-2.1.1[${PYTHON_MULTI_USEDEP}]')
	dev-python/pyotherside[${PYTHON_SINGLE_USEDEP}]"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	sed -i \
		-e "s:python build_qrc.py:${PYTHON} build_qrc.py:" \
		$(qmake-utils_find_pro_file) || die

	python_fix_shebang "${S}"
	default
}

src_configure() {
	eqmake5 $(qmake-utils_find_pro_file)
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	domenu resources/yubioath-desktop.desktop
	doicon resources/icons/yubioath.png
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
