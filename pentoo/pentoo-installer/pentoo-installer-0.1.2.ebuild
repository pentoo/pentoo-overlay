# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="ncurses based install for pentoo, based of the Arch Linux installer"
HOMEPAGE="http://gitorious.org/pentoo/pentoo-installer"
SRC_URI="http://chaox.net/~jens/$P.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-util/dialog
		 <sys-boot/grub-1"

src_install() {
	newsbin setup $PN
}
