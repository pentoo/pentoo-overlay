
EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake-utils

DESCRIPTION="SDR++ is a cross-platform and open source SDR software with the aim of being bloat free and simple to use."
HOMEPAGE="https://github.com/AlexandreRouma/SDRPlusPlus"

SLOT="0"
LICENSE="GPL-3"

IUSE=" +audiosink +rtlsdr soapysdr hackrf airspy airspyhf plutosdr discord portaudio bladerf limesdr spyserver"

PATCHES=( "${FILESDIR}/fix-cmake-libdir-location-1.0.4.patch" )

DEPEND="sci-libs/fftw
    media-libs/glfw
    media-libs/glew
    sci-libs/volk
    airspy? ( net-wireless/airspy )
    airspyhf? ( net-wireless/airspyhf )
    bladerf? ( net-wireless/bladerf )
    hackrf? ( net-wireless/libhackrf )
    limesdr? ( net-wireless/limesuite )
    rtlsdr? ( net-wireless/rtl-sdr )
    soapysdr? ( net-wireless/soapysdr )
    audiosink? ( media-libs/rtaudio )
    portaudio? ( media-libs/portaudio )
    plutosdr? ( net-libs/libiio
        net-libs/libad9361-iio )"


if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/AlexandreRouma/SDRPlusPlus.git"
    inherit git-r3
else
	SRC_URI="https://github.com/AlexandreRouma/SDRPlusPlus/archive/${PV}.tar.gz"
    S="${WORKDIR}/SDRPlusPlus-${PV}"
	KEYWORDS="~amd64 ~arm ~x86"
fi



src_configure() {
    local mycmakeargs=(
        -DOPT_BUILD_AIRSPY_SOURCE=$(usex airspy)
        -DOPT_BUILD_AIRSPYHF_SOURCE=$(usex airspyhf)
        -DOPT_BUILD_SOAPY_SOURCE=$(usex soapysdr)
        -DOPT_BUILD_HACKRF_SOURCE=$(usex hackrf)
        -DOPT_BUILD_PLUTOSDR_SOURCE=$(usex plutosdr)
        -DOPT_BUILD_RTL_SDR_SOURCE=$(usex rtlsdr)
        -DOPT_BUILD_AUDIO_SINK=$(usex audiosink)
        -DOPT_BUILD_DISCORD_PRESENCE=$(usex discord)
        -DOPT_BUILD_PORTAUDIO_SINK=$(usex portaudio)
        -DOPT_BUILD_BLADERF_SOURCE=$(usex bladerf)
        -DOPT_BUILD_LIMESDR_SOURCE=$(usex limesdr)
        -DOPT_BUILD_SPYSERVER_SOURCE=$(usex spyserver)
    )

    cmake-utils_src_configure
}

