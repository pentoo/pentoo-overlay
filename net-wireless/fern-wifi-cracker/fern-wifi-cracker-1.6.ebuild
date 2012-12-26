# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4
PYTHON_DEPEND="2"

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
	dev-lang/python[sqlite]
	dict? ( sys-apps/cracklib-words )
	net-wireless/reaver"
#x11-terms/xterm

S="${WORKDIR}"

src_unpack() {
	unpack ${A} ./data.tar.gz
	find ./ -name .svn | xargs rm -r
}

#src_prepare() {
#	epatch "${FILESDIR}"/${PN}-noupgrade.patch
#}

src_install() {
	insinto /usr/share/fern-wifi-cracker
	doins -r opt/Fern-Wifi-Cracker/*
	domenu ${FILESDIR}/fern-wifi-cracker.desktop
	dosbin "${FILESDIR}"/fern-wifi-cracker
}
