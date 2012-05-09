# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="ncurses based installer for pentoo, based on the Arch Linux installer"
HOMEPAGE="http://gitorious.org/pentoo/pentoo-installer"
SRC_URI="http://dev.pentoo.ch/~jensp/distfiles/$P.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND="dev-util/dialog
	|| ( <sys-boot/grub-1
	     <sys-boot/grub-static-1 )
	net-misc/rsync"

src_prepare() {
	epatch "${FILESDIR}"/7500-ext4.patch
}

src_install() {
	newsbin setup $PN
}
