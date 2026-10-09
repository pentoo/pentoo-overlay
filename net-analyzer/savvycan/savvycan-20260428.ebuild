# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Qt based cross platform CAN bus analysis and reverse engineering tool"
HOMEPAGE="https://github.com/collin80/SavvyCAN"

EGIT_COMMIT="867506199b5d357565cf7b7e74226c3ed33cad87"
SRC_URI="https://github.com/collin80/SavvyCAN/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SavvyCAN-${EGIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-qt/qtbase:6=[dbus,gui,network,opengl,widgets]
	dev-qt/qtdeclarative:6=
	dev-qt/qtserialbus:6=
	dev-qt/qtserialport:6=
	dev-qt/qttools:6=[assistant]
"
DEPEND="${RDEPEND}"

# https://github.com/collin80/SavvyCAN/pull/1098
PATCHES=(
	"${FILESDIR}/${P}-handler_factory.patch"
)

src_configure() {
	eqmake6 SavvyCAN.pro PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
