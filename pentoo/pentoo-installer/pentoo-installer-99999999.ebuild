# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Installer for pentoo, based on the ncurses Arch Linux installer"
HOMEPAGE="https://github.com/pentoo/pentoo-installer"
EGIT_REPO_URI="https://github.com/pentoo/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
if [[ "${PV}" == "99999999" ]] ; then
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS="amd64 x86"
	SRC_URI="https://dev.pentoo.ch/~zero/distfiles/${P}.tar.xz"
fi

IUSE=""

PDEPEND="dev-util/dialog
	sys-apps/util-linux
	sys-block/parted
	sys-boot/efibootmgr
	sys-boot/grub:2[multislot(-)]
	sys-boot/os-prober
	sys-boot/shim
	sys-boot/mokutil
	app-crypt/pinentry[gtk,ncurses]
	sys-fs/squashfs-tools
	x11-misc/wmctrl
	net-misc/rsync"
#	X? ( x11-misc/xdialog )

src_install() {
	dodir /usr/
	cp -R "${S}"/* "${ED}"/usr/ || die "Copy files failed"
	exeinto /root/Desktop/
	doexe share/applications/pentoo-installer.desktop
	exeinto /etc/skel/Desktop/
	newexe share/applications/sudo-pentoo-installer.desktop pentoo-installer.desktop
}
