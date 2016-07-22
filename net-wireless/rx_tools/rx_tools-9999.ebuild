# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="rx_fm, rx_power, and rx_sdr tools for receiving data from SDRs"
HOMEPAGE="https://github.com/rxseger/rx_tools"

EGIT_REPO_URI="https://github.com/rxseger/rx_tools.git"
EGIT_CLONE_TYPE="shallow"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-wireless/soapysdr"
DEPEND="${RDEPEND}"
