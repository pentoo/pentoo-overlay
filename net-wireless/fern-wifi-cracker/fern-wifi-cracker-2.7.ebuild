# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit python-r1 desktop

DESCRIPTION="Wireless tool for WEP/WPA cracking and WPS keys recovery"
HOMEPAGE="https://github.com/savio-code/fern-wifi-cracker/releases"
SRC_URI="https://github.com/savio-code/fern-wifi-cracker/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dict"

DEPEND=""
RDEPEND="dev-python/PyQt5
	net-analyzer/macchanger
	net-wireless/aircrack-ng
	net-analyzer/scapy
	dict? ( sys-apps/cracklib-words )
	|| ( net-wireless/reaver-wps-fork-t6x net-wireless/reaver )"

S="${WORKDIR}/${P}/Fern-Wifi-Cracker"

src_prepare() {
	#disable updates
	sed -ie "s|self.connect(self.update_button|#self.connect(self.update_button|" core/fern.py
	sed -ie "s|thread.start_new_thread(self.update_initializtion_check|#thread.start_new_thread(self.update_initializtion_check|" core/fern.py
	eapply_user
}

src_install() {
	insinto /usr/share/fern-wifi-cracker
	doins -r *
	domenu "${FILESDIR}"/fern-wifi-cracker.desktop
	dosbin "${FILESDIR}"/fern-wifi-cracker
}
