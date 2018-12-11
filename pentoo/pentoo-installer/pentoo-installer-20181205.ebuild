# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Installer for pentoo, based on the ncurses Arch Linux installer"
HOMEPAGE="https://github.com/pentoo/pentoo-installer"

LICENSE="GPL-3"
SLOT="0"

if [[ "${PV}" == "99999999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pentoo/${PN}.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	GIT_COMMIT="909b10bfc57d49e841eedb21f5af2642d1baff0e"
	SRC_URI="https://github.com/pentoo/pentoo-installer/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${GIT_COMMIT}"
fi

IUSE=""

PDEPEND="dev-util/dialog
	sys-apps/util-linux
	sys-block/parted
	sys-boot/efibootmgr
	sys-boot/grub:2[multislot(-),grub_platforms_efi-32,grub_platforms_efi-64]
	sys-boot/os-prober
	sys-boot/shim
	sys-boot/mokutil
	app-crypt/pinentry[gtk,ncurses]
	sys-fs/squashfs-tools
	x11-misc/wmctrl
	net-misc/rsync
	app-misc/jq
	sys-fs/growpart"
#	X? ( x11-misc/xdialog )

src_install() {
	dodir /usr/
	cp -R "${S}"/* "${ED}"/usr/ || die "Copy files failed"
	exeinto /etc/skel/Desktop/
	newexe share/applications/sudo-pentoo-installer.desktop pentoo-installer.desktop
}
