# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11})
inherit distutils-r1

DESCRIPTION="Reader for the RADEX RD1212 and the RADEX ONE Geiger counters"
HOMEPAGE="https://github.com/luigifab/python-radexreader"
SRC_URI="https://github.com/luigifab/python-radexreader/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND=""
RDEPEND="${DEPEND}
		dev-python/pyserial
		dev-python/pyusb
		${PYTHON_DEPS}"
BDEPEND=""

S="${WORKDIR}/python-${P}/src"

src_install() {
	distutils-r1_src_install
	newbin "${PN}".py "${PN}"
}
