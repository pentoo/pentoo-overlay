# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SDR Rx/Tx software"
HOMEPAGE="https://github.com/f4exb/sdrangel"
SRC_URI=""

if [[ ${PV} =~ "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/f4exb/sdrangel.git"
else
	SRC_URI="https://github.com/f4exb/sdrangel/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="airspy bladerf cpu_flags_x86_ssse3 cpu_flags_x86_sse4_1 fcd -debug -doc -gui hackrf limesuite plutosdr rtlsdr server soapy uhd"

# TODO: perseus, xtrx, mirisdr

RDEPEND="
	dev-libs/boost
	dev-libs/cm256cc
	dev-libs/serialDV
	>=media-libs/codec2-0.9.1
	media-libs/opus
	net-wireless/dsdcc
	sci-libs/fftw:3.0
	virtual/libusb:1
	>=dev-qt/qtcore-5.6.0
	>=dev-qt/qtwidgets-5.6.0
	>=dev-qt/qtwebsockets-5.6.0
	>=dev-qt/qtmultimedia-5.6.0[widgets]
	dev-qt/qtserialport
	gui? (
		dev-qt/qtwebengine
		dev-qt/qtdeclarative
		dev-qt/qtpositioning
		dev-qt/qtlocation
		dev-qt/qtcharts
		dev-qt/qtspeech
		dev-qt/qtnetwork
		dev-qt/qtgui
		>=dev-qt/qtopengl-5.6.0
	)
	media-libs/opencv
	media-video/ffmpeg
	airspy? ( net-wireless/airspy )
	bladerf? ( net-wireless/bladerf )
	hackrf? ( net-libs/libhackrf )
	plutosdr? ( net-libs/libiio )
	limesuite? ( net-wireless/limesuite )
	rtlsdr? ( net-wireless/rtl-sdr )
	soapy? ( net-wireless/soapysdr )
	uhd? ( net-wireless/uhd )
	"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	"

src_prepare() {
	sed -i '/ARCH_OPT/,+1 d' CMakeLists.txt
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
		-DENABLE_SOAPYSDR="$(usex soapy)" \
		-DENABLE_USRP="$(usex uhd)" \
		-DENABLE_XTRX=OFF \
	)
	cmake_src_configure
}
