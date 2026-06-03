# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

DESCRIPTION="User mode driver for Airspy HF+"
HOMEPAGE="https://github.com/airspy/airspyhf"
LICENSE="BSD"
SLOT="0"

IUSE="udev static-libs"

RDEPEND="dev-libs/libusb:1
	udev? ( virtual/udev )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/airspy/airspyhf.git"
	inherit git-r3
else
	SRC_URI="https://github.com/airspy/airspyhf/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
	S="${WORKDIR}/airspyhf-${PV}"
	KEYWORDS="~amd64 ~arm ~x86"
fi

PATCHES=( "${FILESDIR}/airspyhf-gcc15.patch" )

src_install() {
	if use udev; then
	    udev_dorules tools/52-airspyhf.rules
	fi

	cmake_src_install
	if ! use static-libs; then
		find "${D}" -name "libairspyhf*.a" -delete

		local manifest="${S}_build/install_manifest.txt"
		if [[ -f "${manifest}" ]]; then
		    sed -i '/\/usr\/lib64\/libairspyhf\.a/d' "${manifest}"
		fi
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
