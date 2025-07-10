# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Desktop application for updating Flipper Zero firmware via PC"
HOMEPAGE="https://update.flipperzero.one/"

LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~amd64 ~arm64 ~x86"
SRC_URI="https://github.com/flipperdevices/qFlipper/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qFlipper-${PV}"
IUSE=""

RDEPEND="
	>=dev-libs/nanopb-0.4.5[pb-malloc]
	dev-qt/qtbase:6=[concurrent,evdev,gui,network,widgets]
	dev-qt/qtdeclarative:6=
	dev-qt/qtserialport:6=
	dev-qt/qtshadertools:6=
	dev-qt/qtsvg:6=
	dev-qt/qttools:6=
	dev-qt/qtwayland:6=
	dev-qt/qt5compat:6=
	sys-libs/zlib:=
	virtual/libusb:1
"
DEPEND="${RDEPEND}"

# https://github.com/flipperdevices/qFlipper/issues/213
PATCHES=(
	"${FILESDIR}/${PN}_define_operator_qt6.9.patch"
	"${FILESDIR}/${PN}-1.3.0_unbundle.patch"
	"${FILESDIR}/${P}_display_version.patch"
)

src_configure() {
	local qmake_args=(
		qFlipper.pro
		PREFIX="${EPREFIX}/usr"
		-spec linux-g++
		CONFIG+=qtquickcompiler
		DEFINES+=DISABLE_APPLICATION_UPDATES
	)
	eqmake6 "${qmake_args[@]}"
}

src_compile() {
	emake qmake_all # rebuild Makefiles in subdirs
	emake
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${ED}" install
}
