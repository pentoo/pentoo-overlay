# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit python-r1 eutils subversion

DESCRIPTION="Wireless tool for WEP/WPA cracking and WPS keys recovery"
HOMEPAGE="https://code.google.com/p/fern-wifi-cracker/"
SRC_URI=""
ESVN_REPO_URI="http://fern-wifi-cracker.googlecode.com/svn/Fern-Wifi-Cracker/"
ESVN_REVISION="218"

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

src_install() {
	insinto /usr/share/fern-wifi-cracker
	doins -r *
#	domenu "${FILESDIR}"/fern-wifi-cracker.desktop
	#symlinking won't work here
	dosbin "${FILESDIR}"/fern-wifi-cracker
}
