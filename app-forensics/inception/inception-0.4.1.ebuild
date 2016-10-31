# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )
inherit linux-info python-r1

DESCRIPTION="Firewire physical memory manipulation tool exploiting IEEE 1394 SBP-2 DMA"
HOMEPAGE="http://www.breaknenter.org/projects/inception/"
SRC_URI="https://github.com/carmaa/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-forensics/libforensic1394"

pkg_setup() {
	CONFIG_CHECK=~FIREWIRE_OHCI
	linux-info_pkg_setup
}

src_install () {
	dodoc README.md

	rm -r licenses inception/test/
	rm README.md setup.py

	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/incept /usr/sbin/inception
}
