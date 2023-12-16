# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Decode, monitor, record and stream trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
BPV="${PV/_/-}"
MY_PV="${BPV/beta/beta-}"
SRC_URI="https://github.com/DSheirer/sdrtrunk/releases/download/v${MY_PV}/sdr-trunk-linux-x86_64-v${MY_PV}.zip"

KEYWORDS="amd64 x86"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/jre:*
	media-libs/alsa-lib
	app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	media-video/ffmpeg
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/pango
	!net-wireless/sdrtrunk
"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/sdr-trunk-linux-x86_64-v${MY_PV}"

QA_PREBUILT="opt/sdrtrunk/bin/* opt/sdrtrunk/lib/*/* opt/sdrtrunk/lib/*"

QA_PRESTRIPPED="opt/sdrtrunk/lib/minimal/libjvm.so"

src_install() {
	dodir /opt/sdrtrunk/
	cp -R * "${ED}"/opt/sdrtrunk/

	dosym "../../${EPREFIX}"/opt/sdrtrunk/bin/sdr-trunk /usr/bin/sdr-trunk
}
