# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 linux-mod udev

DESCRIPTION="Razer Drivers for Linux (Blackwidow TE 2014 test branch)"
HOMEPAGE="https://openrazer.github.io/"
#EGIT_BRANCH="feature_blackwidow_te_0x011c"
HASH_COMMIT="50d373d59daa4dc92692085fabd4a01f23d31f6e"
SRC_URI="https://github.com/openrazer/openrazer/archive/${HASH_COMMIT}.zip -> ${P}.zip"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/libsdl2
	media-libs/sdl2-image
	sci-libs/fftw:3.0
	dev-python/daemonize[$PYTHON_USEDEP]
	dev-python/dbus-python[$PYTHON_USEDEP]
	dev-python/notify2[$PYTHON_USEDEP]
	dev-python/numpy[$PYTHON_USEDEP]
	dev-python/pygobject:*[$PYTHON_USEDEP]
	dev-python/python-evdev[$PYTHON_USEDEP]
	dev-python/pyudev[$PYTHON_USEDEP]
	dev-python/setproctitle[$PYTHON_USEDEP]
	x11-misc/xautomation
	x11-misc/xdotool"
DEPEND="${RDEPEND}
	app-misc/jq"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

BUILD_TARGETS="clean driver"
BUILD_PARAMS="-C ${S} KERNELDIR=${KERNEL_DIR}"
MODULE_NAMES="
	razerkbd(kernel/driver/hid:${S}/driver)
	razermouse(kernel/driver/hid:${S}/driver)
	razermousemat(kernel/driver/hid:${S}/driver)
	razerkraken(kernel/driver/hid:${S}/driver)
	razeraccessory(kernel/driver/hid:${S}/driver)
	razercore(kernel/driver/hid:${S}/driver)
"

src_prepare() {
	default
	# Fix jobserver unavailable
	sed -i  -e '/daemon install$/s/make/$(MAKE)/' \
	-e '/pylib install$/s/@make/$(MAKE)/' \
	Makefile || die "sed failed for Makefile"
	# Do not to install compressed files
	sed -i '/gzip/d' daemon/Makefile || die "sed failed for daemon/Makefile"
}

src_compile() {
	linux-mod_src_compile

	compile_python() {
		pushd pylib
		distutils-r1_python_compile
		popd

		pushd daemon
		distutils-r1_python_compile
		popd
	}
	python_foreach_impl compile_python
}

src_install() {
	linux-mod_src_install

	udev_dorules install_files/udev/99-razer.rules
	exeinto "$(get_udevdir)"
	doexe install_files/udev/razer_mount

	mypython_install() {
		pushd pylib
		distutils-r1_python_install
		popd

		pushd daemon
		distutils-r1_python_install
		emake DESTDIR="${D}" install-resources
		popd
	}
	python_foreach_impl mypython_install
}
