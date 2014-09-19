# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit python-r1 eutils subversion versionator
AVC=( $(get_version_components) )

DESCRIPTION="Wireless tool for WEP/WPA cracking and WPS keys recovery"
HOMEPAGE="https://code.google.com/p/fern-wifi-cracker/"
SRC_URI=""
ESVN_REPO_URI="http://fern-wifi-cracker.googlecode.com/svn/Fern-Wifi-Cracker/"
ESVN_REVISION="${AVC[2]/p/}"

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

src_prepare() {
	#disable updates
	sed -ie "s|self.connect(self.update_button|#self.connect(self.update_button|" core/fern.py
	sed -ie "s|thread.start_new_thread(self.update_initializtion_check|#thread.start_new_thread(self.update_initializtion_check|" core/fern.py
}

src_install() {
	insinto /usr/share/fern-wifi-cracker
	doins -r *
#	domenu "${FILESDIR}"/fern-wifi-cracker.desktop
	#symlinking won't work here
	dosbin "${FILESDIR}"/fern-wifi-cracker
}
