# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Desktop application for updating Flipper Zero firmware via PC"
HOMEPAGE="
	https://update.flipperzero.one/
"

MY_PV="${PV//_/-}"

LICENSE="GPL-3+"
SLOT="0"
if [[ "${PV}" == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flipperdevices/qFlipper.git"
else
	KEYWORDS="amd64 ~arm64 x86"
	SRC_URI="https://github.com/flipperdevices/qFlipper/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/qFlipper-${MY_PV}"
fi
IUSE="+qt5"
REQUIRED_USE="^^ ( qt5 )"

RDEPEND="
	>=dev-libs/nanopb-0.4.5[pb-malloc]
	qt5? (
		dev-qt/qtconcurrent:5=
		dev-qt/qtcore:5=
		dev-qt/qtdeclarative:5=
		dev-qt/qtgui:5=
		dev-qt/qtnetwork:5=
		dev-qt/qtquickcontrols:5=
		dev-qt/qtquickcontrols2:5=
		dev-qt/qtserialport:5=
		dev-qt/qtsvg:5=
		dev-qt/qtwidgets:5=
	)
	sys-libs/zlib:=
	virtual/libusb:1
"
DEPEND="${RDEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-1.2.0_unbundle.patch"
	"${FILESDIR}/${PN}-1.2.2_display_version.patch"
)

src_configure() {
	eqmake5 qFlipper.pro PREFIX="${EPREFIX}/usr" -spec linux-g++ \
		CONFIG+=qtquickcompiler DEFINES+=DISABLE_APPLICATION_UPDATES
}

src_compile() {
	emake qmake_all # rebuild Makefiles in subdirs
	emake
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${ED}" install
}
