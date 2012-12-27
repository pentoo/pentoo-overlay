# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="2:2.7"

inherit python eutils

DESCRIPTION="Wireless tool for WEP/WPA cracking and WPS keys recovery"
HOMEPAGE="https://code.google.com/p/fern-wifi-cracker/"
SRC_URI="https://fern-wifi-cracker.googlecode.com/files/Fern-Wifi-Cracker_1.6_all.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dict"

DEPEND=""
RDEPEND="dev-python/PyQt4[webkit]
	net-analyzer/macchanger
	net-wireless/aircrack-ng
	net-analyzer/scapy
	dict? ( sys-apps/cracklib-words )
	net-wireless/reaver"
#x11-terms/xterm

S="${WORKDIR}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A} ./data.tar.gz
	find ./ -name .svn | xargs rm -r
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	insinto /usr/share/fern-wifi-cracker
	doins -r opt/Fern-Wifi-Cracker/*
	domenu "${FILESDIR}"/fern-wifi-cracker.desktop
	#symlinking won't work here
	dosbin "${FILESDIR}"/fern-wifi-cracker
}
