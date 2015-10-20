# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Installer for pentoo, based on the ncurses Arch Linux installer"
HOMEPAGE="https://code.google.com/p/pentoo/"
EGIT_REPO_URI="https://github.com/pentoo/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
#if [[ "${PV}" == "99999999" ]] ; then
	KEYWORDS=""
#else
#	KEYWORDS="amd64 x86"
#	ESVN_REVISION="head"
#fi

IUSE="debug"

#DEPEND="app-arch/xz-utils"
PDEPEND="dev-util/dialog
	sys-apps/util-linux
	sys-block/parted
	|| ( sys-boot/grub:0
	     sys-boot/grub-static:0 )
	sys-boot/grub:2
	sys-fs/squashfs-tools
	net-misc/rsync"
#	X? ( x11-misc/xdialog )

src_install() {
	dodir /usr/
	cp -R "${S}"/* "${ED}"/usr/ || die "Copy files failed"
	use debug && sed -i 's:#!/bin/bash:#!/bin/bash -x:' $(find "${ED}/usr/share/pentoo-installer" -type f)
	exeinto /root/Desktop/
	doexe share/applications/pentoo-installer.desktop
}
