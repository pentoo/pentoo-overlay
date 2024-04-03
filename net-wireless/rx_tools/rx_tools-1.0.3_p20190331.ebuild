# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit cmake

DESCRIPTION="rx_fm, rx_power, and rx_sdr tools for receiving data from SDRs"
HOMEPAGE="https://github.com/rxseger/rx_tools"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/rxseger/rx_tools.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86"
	#SRC_URI="https://github.com/rxseger/rx_tools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/rxseger/rx_tools/archive/811b21c4c8a592515279bd19f7460c6e4ff0551c.tar.gz -> ${P}.tar.gz"
	inherit vcs-snapshot
fi

SLOT="0"
LICENSE="GPL-2"

RDEPEND="net-wireless/soapysdr:="
DEPEND="${RDEPEND}"
