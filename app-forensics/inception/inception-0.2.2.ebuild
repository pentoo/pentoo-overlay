# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="3"

inherit linux-info python

DESCRIPTION="Firewire physical memory manipulation tool exploiting IEEE 1394 SBP-2 DMA"
HOMEPAGE="http://www.breaknenter.org/projects/inception/"
SRC_URI="https://github.com/carmaa/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-forensics/libforensic1394"

#QA_PRESTRIPPED="/usr/share/inception/samples/ubuntu-11.10-x86-0xbaf.bin"

pkg_setup() {
	python_set_active_version 3
	python_pkg_setup

	CONFIG_CHECK=~FIREWIRE_OHCI
	linux-info_pkg_setup
}

src_install () {
	dodoc README.md samples/SAMPLES.txt

	rm -r licenses samples
	rm README.md bt5-setup.sh setup.py

	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/incept /usr/sbin/inception
}
