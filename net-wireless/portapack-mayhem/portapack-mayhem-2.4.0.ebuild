# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )

DESCRIPTION="Custom firmware for the HackRF SDR + PortaPack H1 addon"
HOMEPAGE="https://github.com/portapack-mayhem/mayhem-firmware"

LICENSE="GPL-2"
SLOT="0"
IUSE="hackrf-sdcard hackrfpro-sdcard portarf-sdcard"

if [ "${PV}" == "9999" ]; then
	inherit cmake flag-o-matic git-r3 python-any-r1
	EGIT_REPO_URI="https://github.com/portapack-mayhem/mayhem-firmware.git"
	EGIT_BRANCH="next"
	BDEPEND="${PYTHON_DEPS}
			sys-devel/gcc-arm-none-eabi
			$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')"
else
	inherit python-utils-r1
	KEYWORDS="~amd64 ~x86"
	# https://github.com/portapack-mayhem/mayhem-firmware/issues/3108
	# https://github.com/portapack-mayhem/mayhem-firmware/issues/3109
	SRC_URI="https://github.com/portapack-mayhem/mayhem-firmware/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
			https://github.com/${PN}/mayhem-firmware/releases/download/v${PV}/FIRMWARE_mayhem_v${PV}.zip -> ${P}-firmware.zip
			hackrf-sdcard? \
				( https://github.com/${PN}/mayhem-firmware/releases/download/v${PV}/COPY_TO_SDCARD_hackrf_mayhem_v${PV}.zip )
			hackrfpro-sdcard? \
				( https://github.com/${PN}/mayhem-firmware/releases/download/v${PV}/COPY_TO_SDCARD_hpro_mayhem_v${PV}.zip )
			portarf-sdcard? \
				( https://github.com/${PN}/mayhem-firmware/releases/download/v${PV}/COPY_TO_SDCARD_portarf_mayhem_v2.4.0.zip )"
	BDEPEND="app-arch/unzip"
fi

BDEPEND="net-wireless/gnuradio"
DEPEND="${PYTHON_DEPS}
	app-arch/unzip
"
RDEPEND="
	>=net-wireless/hackrf-tools-2015.07.2-r1
	>=app-mobilephone/dfu-util-0.7
"

python_check_deps() {
	python_has_version "dev-python/pyyaml[${PYTHON_USEDEP}]"
}

src_unpack() {
	if [ "${PV}" = 9999 ]; then
		git-r3_src_unpack
	else
		unpack "${P}.tar.gz" || die
		mv "mayhem-firmware-${PV}" "${P}"
		pushd "${S}" || die
		unpack "${P}-firmware.zip" || die
		#popd || die
		if use hackrf-sdcard; then
			mkdir hackrf-sdcard || die
			pushd hackrf-sdcard || die
			unpack "COPY_TO_SDCARD_hackrf_mayhem_v${PV}.zip" || die
			popd || die
		fi
		if use hackrfpro-sdcard; then
			mkdir hackrfpro-sdcard || die
			pushd hackrfpro-sdcard || die
			unpack "COPY_TO_SDCARD_hpro_mayhem_v${PV}.zip" || die
			popd || die
		fi
		if use portarf-sdcard; then
			mkdir portarf-sdcard || die
			pushd portarf-sdcard || die
			unpack "COPY_TO_SDCARD_portarf_mayhem_v${PV}.zip" || die
			popd || die
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
	pushd "firmware/tools" || die
	grcc -o "${S}" convert_C16_to_complex.grc || die
}

src_install() {
	exeinto /usr/share/${PN}
	doexe firmware/tools/*.py firmware/tools/*.grc
	newexe top_block.py convert_C16_to_complex.py
	insinto /usr/share/${PN}
	if [ "${PV}" = "9999" ]; then
		newins "${BUILD_DIR}/firmware/portapack-h1_h2-mayhem.bin" "portapack-h1_h2-mayhem-${PV}.bin"
	else
		# firmware_hackrf.bin  firmware_hpro.bin	firmware_portarf.bin
		newins "${S}/firmware/firmware_hackrf.bin" "portapack-mayhem-hackrf-${PV}.bin"
		newins "${S}/firmware/firmware_hpro.bin" "portapack-mayhem-hackrfpro-${PV}.bin"
		newins "${S}/firmware/firmware_portarf.bin" "portapack-mayhem-portarf-${PV}.bin"
	fi
	use hackrf-sdcard && doins -r "${S}"/hackrf-sdcard
	use hackrfpro-sdcard && doins -r "${S}"/hackrfpro-sdcard
	use portarf-sdcard && doins -r "${S}"/portarf-sdcard
	dodir /usr/share/hackrf
	ln -s ../${PN}/portapack-mayhem-hackrf-${PV}.bin "${ED}/usr/share/hackrf/portapack-mayhem-hackrf.bin" || die
	ln -s ../${PN}/portapack-mayhem-hackrfpro-${PV}.bin "${ED}/usr/share/hackrf/portapack-mayhem-hackrfpro.bin" || die
	ln -s ../${PN}/portapack-mayhem-portarf-${PV}.bin "${ED}/usr/share/hackrf/portapack-mayhem-portarf.bin" || die
}

pkg_postint() {
	if ! use hackrf-sdcard ; then
		ewarn "hackrf-sdcard use flag is not enabled but these files are *required* for operation with hackrf"
	fi
	if ! use hackrfpro-sdcard ; then
		ewarn "hackrfpro-sdcard use flag is not enabled but these files are *required* for operation with hackrf pro"
	fi
	if ! use portarf-sdcard ; then
		ewarn "portarf-sdcard use flag is not enabled but these files are *required* for operation with portarf"
	fi
}
