# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-20090421.ebuild,v 1.2 2009/04/21 20:46:04 mr_bones_ Exp $

inherit git

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"
SRC_URI=""
EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="!net-wireless/iwl3945-ucode
	!net-wireless/ralink-firmware
	!net-wireless/iwl4965-ucode
	!net-wireless/iwl5000-ucode"
#add anything else that collides to this

src_install() {
	insinto /lib/firmware/
	doins -r * || die "Install failed!"
}
