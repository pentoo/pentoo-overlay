# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Bluetooth radio packet sniffer/scanner and sender"
HOMEPAGE="http://sdr-x.github.io/BTLE-SNIFFER/ https://github.com/JiaoXianjun/BTLE"
HASH_COMMIT=6384cb05285f38cda79a1cd4c91021b2b3dd34b2
SRC_URI="https://github.com/JiaoXianjun/BTLE/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="bladerf +hackrf"

DEPEND="hackrf? ( net-libs/libhackrf )"
RDEPEND="${DEPEND}"

REQUIRED_USE="^^ ( bladerf hackrf )"

S="${WORKDIR}/BTLE-${HASH_COMMIT}/host"

src_configure() {
	#without -DUSE_BLADERF=1 means HACKRF will be used by default
	local mycmakeargs=(
		$(usex bladerf -DUSE_BLADERF=1)
	)
	cmake-utils_src_configure
}
