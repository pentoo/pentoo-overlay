# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Spectrum analyzer software for Signal Hound test equipment"
HOMEPAGE="https://signalhound.com/spike/"
SRC_URI="http://signalhound.com/download/spike-64-bit-linux/ -> ${P}.zip"

LICENSE="no-fucking-clue"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="
	virtual/libusb
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtcore:5
	media-libs/libglvnd
"
BDEPEND=""

S="${WORKDIR}/Spike(Ubuntu20.04x64)_3_5_9"

QA_PREBUILT="*"

src_install() {
	exeinto /opt/signalhound-spike/bin
	doexe bin/spike

	insinto /opt/signalhound-spike/lib
	doins lib/libbb_api.so.4.3.0 lib/libsm_api.so.2.1.5 lib/libftd2xx.so

	exeinto /usr/bin
	doexe "${FILESDIR}/spike"
}
