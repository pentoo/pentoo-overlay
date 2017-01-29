# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )
inherit linux-info distutils-r1

DESCRIPTION="Firewire physical memory manipulation tool exploiting IEEE 1394 SBP-2 DMA"
HOMEPAGE="http://www.breaknenter.org/projects/inception/"
SRC_URI="https://github.com/carmaa/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	app-forensics/libforensic1394[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

RESTRICT="binchecks"

#QA_PRESTRIPPED="usr/lib\(32\|64\)\/python\(.*\)\/site-packages/inception/test/samples/ubuntu-11.10-x86-0xbaf.bin
#	usr/lib\(32\|64\)\/python\(.*\)\/site-packages/inception/test/samples/linux-mint-12-x86-0xbaf.bin
#"

pkg_setup() {
	CONFIG_CHECK=~FIREWIRE_OHCI
	linux-info_pkg_setup
}
