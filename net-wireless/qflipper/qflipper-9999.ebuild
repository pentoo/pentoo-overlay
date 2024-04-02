# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

DESCRIPTION="Desktop application for updating Flipper Zero firmware via PC"
HOMEPAGE="https://update.flipperzero.one/"

LICENSE="GPL-3+"
SLOT="0"

if [[ "${PV}" == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flipperdevices/qFlipper.git"
else
	KEYWORDS="~amd64 ~arm64 ~x86"
	SRC_URI="https://github.com/flipperdevices/qFlipper/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/qFlipper-${PV}"
fi
IUSE="+qt5 qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

RDEPEND="
	>=dev-libs/nanopb-0.4.5[pb-malloc]
	qt5? (
		dev-qt/qtconcurrent:5=
		dev-qt/qtcore:5=
		dev-qt/qtdeclarative:5=
		dev-qt/qtgui:5=[jpeg]
		dev-qt/qtnetwork:5=
		dev-qt/qtquickcontrols:5=
		dev-qt/qtquickcontrols2:5=
		dev-qt/qtserialport:5=
		dev-qt/qtsvg:5=
		dev-qt/qtwidgets:5=
	)
	qt6? (
		dev-qt/qtbase:6=[concurrent,evdev,gui,network,widgets]
		dev-qt/qtdeclarative:6=
		dev-qt/qtserialport:6=
		dev-qt/qtshadertools:6=
		dev-qt/qtsvg:6=
		dev-qt/qttools:6=
		dev-qt/qtwayland:6=
		dev-qt/qt5compat:6=
	)
	sys-libs/zlib:=
	virtual/libusb:1
"
DEPEND="${RDEPEND}"

# https://github.com/flipperdevices/qFlipper/issues/213
PATCHES=(
	"${FILESDIR}/${PN}-1.3.0_unbundle.patch"
)

src_configure() {
	local qmake_args=(
		qFlipper.pro
		PREFIX="${EPREFIX}/usr"
		-spec linux-g++
		CONFIG+=qtquickcompiler
		DEFINES+=DISABLE_APPLICATION_UPDATES
	)
	use qt5 && \
		eqmake5 "${qmake_args[@]}"
	use qt6 && \
		eqmake6 "${qmake_args[@]}"
}

src_compile() {
	emake qmake_all # rebuild Makefiles in subdirs
	emake
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${ED}" install
}
