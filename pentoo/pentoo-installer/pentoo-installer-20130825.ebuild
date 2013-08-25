# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion

DESCRIPTION="Installer for pentoo, based on the ncurses Arch Linux installer"
HOMEPAGE="http://gitorious.org/pentoo/pentoo-installer"
SRC_URI=""
ESVN_REPO_URI="https://pentoo.googlecode.com/svn/${PN}/trunk"
ESVN_REVISION="4938"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND="dev-util/dialog
	|| ( <sys-boot/grub-1
	     <sys-boot/grub-static-1 )
	net-misc/rsync"

src_install() {
	dodir /usr/
	cp -R "${S}"/* "${ED}"/usr/ || die "Copy files failed"
	exeinto /root/Desktop/
	doexe /usr/share/applications/pentoo-installer.desktop
}
