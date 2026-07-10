# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SDR Rx/Tx software"
HOMEPAGE="https://github.com/f4exb/sdrangel"

if [[ ${PV} =~ "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/f4exb/sdrangel.git"
else
	SRC_URI="https://github.com/f4exb/sdrangel/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="airspy bladerf cpu_flags_x86_ssse3 cpu_flags_x86_sse4_1 fcd debug doc +gui hackrf limesuite plutosdr rtlsdr server soapy uhd"

REQUIRED_USE="
	airspy? ( || ( gui server ) )
	bladerf? ( || ( gui server ) )
	fcd? ( || ( gui server ) )
	hackrf? ( || ( gui server ) )
	limesuite? ( || ( gui server ) )
	plutosdr? ( || ( gui server ) )
	rtlsdr? ( || ( gui server ) )
	soapy? ( || ( gui server ) )
	uhd? ( || ( gui server ) )
"

# TODO: perseus, xtrx, mirisdr
RDEPEND="
	media-libs/opus
	sci-libs/fftw:3.0=
	dev-qt/qtbase:6[widgets]
	dev-qt/qtwebsockets:6
	dev-qt/qtmultimedia:6
	dev-qt/qtpositioning:6
	dev-qt/qt5compat:6
	airspy? ( net-wireless/airspy )
	bladerf? ( net-wireless/bladerf:= )
	fcd? ( dev-libs/hidapi )
	hackrf? ( net-libs/libhackrf:= )
	plutosdr? ( net-libs/libiio:= )
	limesuite? ( net-wireless/limesuite )
	rtlsdr? ( net-wireless/rtl-sdr )
	soapy? ( net-wireless/soapysdr:= )
	uhd? ( net-wireless/uhd:= )
	gui? (
		dev-qt/qtcharts:6
		dev-qt/qtdeclarative:6
		dev-qt/qtsvg:6
		dev-qt/qtspeech:6
		dev-qt/qtlocation:6
		dev-qt/qtwebengine:6
		dev-qt/qtscxml:6

		dev-qt/qtserialport:6
		media-libs/opencv:=
		dev-libs/cm256cc
		dev-libs/serialDV
		>=media-libs/codec2-0.9.1:=
		media-libs/hamlib:=
		media-video/ffmpeg:=
		net-wireless/dsdcc
	)
	server? (
		dev-qt/qtserialport:6
		media-libs/opencv:=
		dev-libs/cm256cc
		dev-libs/serialDV
		>=media-libs/codec2-0.9.1:=
		media-libs/hamlib:=
		media-video/ffmpeg:=
		net-wireless/dsdcc
	)
	"

DEPEND="${RDEPEND}
	dev-libs/boost
	doc? ( app-text/doxygen )
	"

src_prepare() {
	sed -i '/ARCH_OPT/,+1 d' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DDEBUG_OUTPUT="$(usex debug)" \
		-DSANITIZE_ADDRESS=OFF \
		-DRX_SAMPLE_24BIT=ON \
		-DBUILD_SERVER="$(usex server)" \
		-DBUILD_GUI="$(usex gui)" \
		-DENABLE_AIRSPY="$(usex airspy)" \
		-DENABLE_AIRSPYHF="$(usex airspy)" \
		-DENABLE_BLADERF="$(usex bladerf)" \
		-DWITH_DOC="$(usex doc)" \
		-DENABLE_FUNCUBE="$(usex fcd)" \
		-DENABLE_HACKRF="$(usex hackrf)" \
		-DENABLE_IIO="$(usex plutosdr)" \
		-DENABLE_LIMESUITE="$(usex limesuite)" \
		-DENABLE_MIRISDR=OFF \
		-DENABLE_PERSEUS=OFF \
		-DENABLE_QT6=ON \
		-DENABLE_RTLSDR="$(usex rtlsdr)" \
		-DENABLE_SOAPYSDR="$(usex soapy)" \
		-DENABLE_USRP="$(usex uhd)" \
		-DENABLE_XTRX=OFF
	)
	cmake_src_configure
	sed -i 's#-isystem /usr/include/qt6/QtSvg#-isystem /usr/include/qt6/QtSvg -isystem /usr/include/qt6/QtSvgWidgets#g' \
		"${BUILD_DIR}"/build.ninja || die
}
