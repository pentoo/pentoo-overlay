# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Records calls from a Trunked Radio System (P25 & SmartNet)"
HOMEPAGE="https://github.com/robotastic/trunk-recorder"
if [[ "${PV}" = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/robotastic/trunk-recorder.git"
	#EGIT_BRANCH="dmr-metadata"
	inherit git-r3
	RESTRICT="strip"
else
	SRC_URI="https://github.com/robotastic/trunk-recorder/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="net-wireless/gr-osmosdr:=
	net-wireless/gnuradio:=[uhd]
	net-wireless/uhd:=
	!net-wireless/op25
	net-misc/curl:=
	dev-libs/log4cpp:=
	dev-libs/openssl:0=
	dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND=""
