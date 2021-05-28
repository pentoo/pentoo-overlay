# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit toolchain-funcs eutils

DESCRIPTION="Mode S decoder for (SDR) devices including RTL SDR, HackRF, Airspy and SDRplay"
HOMEPAGE="https://github.com/itemir/dump1090_sdrplus"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/itemir/${PN}.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	HASH_COMMIT="a21346b5570b7dee49ca590ddde112705ddd3c45"
	SRC_URI="https://github.com/itemir/dump1090_sdrplus/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="net-wireless/rtl-sdr:=
	net-libs/libhackrf
	net-wireless/airspy
	net-wireless/sdrplay
	media-libs/soxr"

DEPEND="${RDEPEND}"

src_install() {
	newbin dump1090 ${PN}
	dodoc README.md
}
