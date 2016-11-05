# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="A BTLE (Bluetooth Low energy)/BT4.0 radio packet sniffer/scanner and sender"
HOMEPAGE="http://sdr-x.github.io/BTLE-SNIFFER/"
SRC_URI="https://github.com/JiaoXianjun/BTLE/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="bladerf +hackrf"

DEPEND="hackrf? ( net-libs/libhackrf )"
RDEPEND="${DEPEND}"

REQUIRED_USE="^^ ( bladerf hackrf )"

S="${WORKDIR}/BTLE-${PV}/host"

src_configure() {
	#without -DUSE_BLADERF=1 means HACKRF will be used by default
	local mycmakeargs=(
		$(usex bladerf -DUSE_BLADERF=1)
	)
	cmake-utils_src_configure
}
