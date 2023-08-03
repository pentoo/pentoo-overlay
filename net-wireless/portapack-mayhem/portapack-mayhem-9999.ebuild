# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

DESCRIPTION="Custom firmware for the HackRF SDR + PortaPack H1 addon"
HOMEPAGE="https://github.com/eried/portapack-mayhem"

LICENSE="GPL-2"
SLOT="0"
IUSE="sdcard-files"

if [ "${PV}" == "9999" ]; then
	inherit cmake flag-o-matic git-r3 python-any-r1
	EGIT_REPO_URI="https://github.com/eried/portapack-mayhem.git"
	EGIT_BRANCH="next"
	BDEPEND="${PYTHON_DEPS}
			sys-devel/gcc-arm-none-eabi
			$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')"
else
	inherit python-utils-r1
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/eried/${PN}/releases/download/v${PV}/mayhem_v${PV}_FIRMWARE.zip
			sdcard-files? ( https://github.com/eried/${PN}/releases/download/v${PV}/mayhem_v${PV}_COPY_TO_SDCARD.zip )"
	BDEPEND="app-arch/unzip"
fi

RDEPEND=">=net-wireless/hackrf-tools-2015.07.2-r1
	>=app-mobilephone/dfu-util-0.7"

python_check_deps() {
	python_has_version "dev-python/pyyaml[${PYTHON_USEDEP}]"
}

src_unpack() {
	if [ "${PV}" = 9999 ]; then
		git-r3_src_unpack
	else
		#upstream distfiles unpack into current directory
		mkdir ${P}
		pushd ${P}
		unpack mayhem_v${PV}_FIRMWARE.zip
		if use sdcard-files; then
			mkdir sdcard
			pushd sdcard
			unpack mayhem_v${PV}_COPY_TO_SDCARD.zip
		fi
	fi
}

src_configure() {
	if [ "${PV}" = "9999" ]; then
		strip-flags
		filter-flags "-march=*" "-mtune=*"
		cmake_src_configure
	else
		true
	fi
}

src_compile() {
	if [ "${PV}" = "9999" ]; then
		V=1 cmake_src_compile
	else
		true
	fi
}

src_install() {
	insinto /usr/share/${PN}
	if [ "${PV}" = "9999" ]; then
		newins "${BUILD_DIR}/firmware/portapack-h1_h2-mayhem.bin" "portapack-h1_h2-mayhem-${PV}.bin"
	else
		newins "${S}/portapack-h1_h2-mayhem.bin" "portapack-h1_h2-mayhem-${PV}.bin"
	fi
	use sdcard-files && doins -r "${S}"/sdcard
	dodir /usr/share/hackrf
	ln -s ../${PN}/portapack-h1_h2-mayhem-${PV}.bin "${ED}/usr/share/hackrf/portapack-h1_h2-mayhem.bin" || die
}

pkg_postint() {
	if ! use sdcard-files; then
		ewarn "sdcard-files use flag is not enabled but these files are *required* for operation"
		ewarn "it is a good idea to copy these files on the sdcard on your portapack from time to time"
	fi
}
