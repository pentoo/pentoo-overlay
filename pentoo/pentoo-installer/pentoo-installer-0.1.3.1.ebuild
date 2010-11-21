# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="ncurses based installer for pentoo, based on the Arch Linux installer"
HOMEPAGE="http://gitorious.org/pentoo/pentoo-installer"
SRC_URI="http://dev.pentoo.ch/~jensp/distfiles/$P.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/dialog
	|| ( <sys-boot/grub-1
	     <sys-boot/grub-static-1 )
	net-misc/rsync"

src_install() {
	newsbin setup $PN || die
}
