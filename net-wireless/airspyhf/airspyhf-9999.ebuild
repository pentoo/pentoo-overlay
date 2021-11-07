EAPI=7

inherit cmake-utils udev

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"

SLOT="0"
LICENSE="BSD-3"
RDEPEND="dev-libs/libusb:1
    virtual/udev"
DEPEND="${RDEPEND}
    virtual/pkgconfig"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/airspy/airspyhf.git"
    inherit git-r3
else
	SRC_URI="https://github.com/airspy/airspyhf/archive/${PV}.tar.gz"
    S="${WORKDIR}/airspyhf-${PV}"
	KEYWORDS="~amd64 ~arm ~x86"
fi

src_install() {
    udev_dorules tools/52-airspyhf.rules

    cmake-utils_src_install
}