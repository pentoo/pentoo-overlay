# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit linux-info distutils-r1

DESCRIPTION="Firewire physical memory manipulation tool exploiting IEEE 1394 SBP-2 DMA"
HOMEPAGE="http://www.breaknenter.org/projects/inception/"
SRC_URI="https://github.com/carmaa/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	app-forensics/libforensic1394[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

#these are not python tests
RESTRICT="test"

#FIXME: scanelf: .*.bin: Invalid section header info
#QA_PREBUILT=".*/site-packages/inception/test/samples/linux-mint-12-x86-0xbaf.bin"

QA_PRESTRIPPED=".*/test/samples/.*.bin"

pkg_setup() {
	CONFIG_CHECK=~FIREWIRE_OHCI
	linux-info_pkg_setup
}

src_test() {
	${PYTHON} -m unittest discover tests/ "test_*.py" || die
}
