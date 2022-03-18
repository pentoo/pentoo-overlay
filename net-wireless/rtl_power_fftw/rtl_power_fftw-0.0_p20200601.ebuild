# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="power spectrum for RTLSDR dongles"
HOMEPAGE="https://github.com/AD-Vega/rtl-power-fftw"

LICENSE="GPL-3"
SLOT="0"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AD-Vega/rtl-power-fftw.git"
else
	KEYWORDS="~amd64 ~x86"
	COMMIT="cee9a22207ea995bd12adbc6bcfbec92521548b1"
	SRC_URI="https://github.com/AD-Vega/rtl-power-fftw/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN//_/-}-${COMMIT}"
fi

IUSE=""

RDEPEND="dev-cpp/tclap
	sci-libs/fftw:3.0=
	net-wireless/rtl-sdr:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"
