# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="off-grid, decentralized, mesh network"
HOMEPAGE="https://meshtastic.org/docs/hardware/devices/linux-native-hardware/"
SHORT_HASH="a597230"
#SRC_URI="https://github.com/meshtastic/firmware/releases/download/v${PV}.${SHORT_HASH}/meshtasticd-${PV}.21455.local${SHORT_HASH}-src.zip -> ${P}.zip
#		https://github.com/meshtastic/firmware/releases/download/v${PV}.${SHORT_HASH}/platformio-deps-native-tft-${PV}.${SHORT_HASH}.zip -> ${P}-deps.zip"
SRC_URI="https://github.com/meshtastic/firmware/archive/refs/tags/v${PV}.${SHORT_HASH}.tar.gz -> ${P}.tar.gz
		https://github.com/meshtastic/firmware/releases/download/v${PV}.${SHORT_HASH}/platformio-deps-native-tft-${PV}.${SHORT_HASH}.zip -> ${P}-deps.zip"

S="${WORKDIR}/firmware-${PV}.${SHORT_HASH}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/yaml-cpp:=
		dev-libs/libbsd
		dev-libs/libgpiod:=
		dev-libs/libinput:=
		dev-libs/libusb:1
		dev-libs/libuv:=
		dev-libs/openssl:=
		media-libs/libsdl2
		net-wireless/bluez:=
		sys-apps/i2c-tools
		x11-libs/libX11
		x11-libs/libxkbcommon"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip
		dev-embedded/platformio"

src_prepare() {
	default
	mv "${WORKDIR}/pio-deps-native-tft" "${S}/pio" || die
}

src_compile() {
	PLATFORMIO_CORE_DIR=pio/core \
	PLATFORMIO_LIBDEPS_DIR=pio/libdeps \
	PLATFORMIO_PACKAGES_DIR=pio/packages \
	platformio run -e native-tft || die
}

src_install() {
	newexe .pio/build/native-tft/program meshtasticd || die
	insinto /etc/meshtasticd
	newins bin/config-dist.yaml config.yaml || die
	insinto /etc/meshtasticd/available.d
	doins -r bin/config.d/*
	insinto /lib/systemd/system
	doins bin/meshtasticd.service
}
