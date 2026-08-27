# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"
SRC_URI="https://github.com/airspy/airspyhf/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/airspyhf-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="udev static-libs"

RDEPEND="
	dev-libs/libusb:1
	udev? ( virtual/udev )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/airspyhf-gcc15.patch"
	"${FILESDIR}/airspyhf-static-libs.patch"
)

src_configure() {
	local mycmakeargs=(
		-DINSTALL_STATIC_LIBS=$(usex static-libs)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use udev; then
		udev_dorules tools/52-airspyhf.rules
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
