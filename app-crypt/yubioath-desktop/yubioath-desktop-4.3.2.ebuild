# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qmake-utils eutils

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey NEO"
HOMEPAGE="http://opensource.yubico.com/yubioath-desktop"
#https://github.com/Yubico/yubioath-desktop/issues/254
SRC_URI="https://github.com/Yubico/yubioath-desktop/releases/download/${P}/${P}.tar.gz -> ${P}.tar"

KEYWORDS="~amd64"
SLOT="4"
LICENSE="BSD-2"

RDEPEND="dev-qt/qtsingleapplication
	dev-python/pyotherside"
DEPEND="${RDEPEND}
	>=app-crypt/yubikey-manager-0.5"

S="${WORKDIR}/${PN}"

src_prepare() {
	#https://github.com/Yubico/yubioath-desktop/pull/207
	epatch "${FILESDIR}/4.3-qtsingleapp.patch"
	eapply_user
}

src_configure() {
	eqmake5 yubioath-desktop.pro
	python build_qrc.py resources.json
}

src_install() {
	emake install INSTALL_ROOT="${D}"
#    python_optimize  # does all packages by default
	domenu resources/yubioath.desktop
	doicon resources/icons/yubioath.png

	emake compiler_rcc_make_all
	emake compiler_buildqrc_make_all
	emake compiler_moc_header_make_all

}
