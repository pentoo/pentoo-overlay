# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
KEYWORDS=""
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd-stage1"

S="${WORKDIR}"

#things needed for a running pentoo system
RDEPEND="${RDEPEND}
	sys-apps/gptfdisk
	sys-apps/pcmciautils
	sys-kernel/genkernel
	|| ( sys-boot/grub sys-boot/grub-static )
	app-arch/unrar
	app-arch/unzip
	app-portage/gentoolkit
	app-portage/eix
	app-portage/porthole
	sys-apps/pciutils
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	sys-apps/microcode-ctl
	sys-apps/microcode-data
	sys-firmware/amd-ucode
	sys-boot/syslinux
	sys-fs/sshfs-fuse
	sys-libs/gpm
	!arm? ( sys-power/acpid )
	sys-power/cpufrequtils
	sys-power/hibernate-script
	sys-power/powertop
	sys-process/htop
	sys-process/iotop
	sys-boot/unetbootin
	sys-apps/openrc
	app-arch/sharutils
	app-crypt/gnupg
	app-shells/bash-completion
	sys-apps/hdparm
	sys-boot/efibootmgr
	sys-fs/cryptsetup
	dev-libs/icu
	sys-process/lsof
	sys-kernel/pentoo-sources
	app-portage/mirrorselect
	!livecd-stage1? ( amd64? ( sys-fs/zfs ) )
"
