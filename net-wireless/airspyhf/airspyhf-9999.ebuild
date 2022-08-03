EAPI=8

inherit cmake udev

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"

IUSE="udev"

SLOT="0"
LICENSE="BSD"
RDEPEND="dev-libs/libusb:1
		udev? ( virtual/udev )"
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
	if use udev; then
        udev_dorules tools/52-airspyhf.rules
    fi

	cmake_src_install
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
