# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-20090421.ebuild,v 1.2 2009/04/21 20:46:04 mr_bones_ Exp $

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"
SRC_URI=""

inherit git

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/linux-firmware.git"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RDEPEND="!net-wireless/iwl3945-ucode
	!net-wireless/ralink-firmware
	!net-wireless/iwl4965-ucode
	!net-wireless/iwl5000-ucode"
#probably I should add more here but... whatever

src_install() {
	dodir /lib/firmware
	cp -R "${S}/"* "${D}lib/firmware/" || die "Install failed!"
}
