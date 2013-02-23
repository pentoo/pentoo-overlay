# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS=""
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd livecd-stage1 +windows-compat"

S="${WORKDIR}"

#things needed for a running pentoo system
RDEPEND="${RDEPEND}
	!livecd? ( app-portage/portage-utils
		|| ( app-admin/syslog-ng virtual/logger )
		|| ( sys-process/fcron virtual/cron ) )
	sys-apps/gptfdisk
	sys-apps/pcmciautils
	!arm? ( !livecd-stage1? ( sys-kernel/genkernel
		|| ( sys-boot/grub:0 sys-boot/grub-static )
		sys-boot/grub:2 ) )
	app-arch/unrar
	app-arch/unzip
	app-portage/gentoolkit
	app-portage/eix
	app-portage/porthole
	windows-compat? ( app-emulation/wine
		amd64? ( dev-lang/mono ) )
	sys-apps/pciutils
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	!arm? ( sys-apps/microcode-data
		sys-firmware/amd-ucode
		sys-boot/syslinux )
	net-fs/curlftpfs
	sys-fs/sshfs-fuse
	sys-kernel/linux-firmware
	sys-libs/gpm
	!arm? ( sys-power/acpid[pentoo] )
	sys-power/cpufrequtils
	sys-power/hibernate-script
	sys-power/powertop
	sys-process/htop
	sys-process/iotop
	sys-boot/unetbootin
	sys-apps/openrc[pentoo]
	app-arch/sharutils
	app-crypt/gnupg
	app-shells/bash-completion
	sys-apps/hdparm
	sys-boot/efibootmgr
	sys-fs/cryptsetup
	dev-libs/icu
	sys-process/lsof
	!arm? ( sys-kernel/pentoo-sources )
	app-portage/mirrorselect
	!livecd-stage1? ( amd64? ( sys-fs/zfs ) )
	|| ( mail-client/thunderbird-bin mail-client/thunderbird )
"
