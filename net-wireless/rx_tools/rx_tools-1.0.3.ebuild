# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
inherit cmake-utils

DESCRIPTION="rx_fm, rx_power, and rx_sdr tools for receiving data from SDRs"
HOMEPAGE="https://github.com/rxseger/rx_tools"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/rxseger/rx_tools.git"
	inherit git-r3
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/rxseger/rx_tools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="net-wireless/soapysdr"
DEPEND="${RDEPEND}"
