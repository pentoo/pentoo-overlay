# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS="amd64 x86"
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_virtualbox video_cards_vmware"
IUSE="+accessibility +drivers gtk qt4 livecd-stage1 +windows-compat ${IUSE_VIDEO_CARDS}"

S="${WORKDIR}"

#things needed for a running pentoo system
PDEPEND="${PDEPEND}
	!livecd-stage1? ( video_cards_virtualbox? ( app-emulation/virtualbox-guest-additions )
			video_cards_nvidia? ( x11-misc/bumblebee ) )
	app-shells/bash-completion
	app-portage/portage-utils
	|| ( app-admin/syslog-ng virtual/logger )
	|| ( sys-process/fcron virtual/cron )
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
	net-misc/x11-ssh-askpass
	windows-compat? ( app-emulation/wine
		amd64? ( dev-lang/mono ) )
	sys-apps/pciutils
	sys-apps/usbutils
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	!arm? ( sys-apps/microcode-data
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
	sys-apps/hdparm
	sys-boot/efibootmgr
	sys-fs/cryptsetup
	dev-libs/icu
	sys-process/lsof
	gtk? ( media-video/gtk-recordmydesktop )
	qt4? ( !gtk? ( media-video/qt-recordmydesktop ) )
	!arm? ( sys-kernel/pentoo-sources )
	app-portage/mirrorselect
	!livecd-stage1? ( amd64? ( sys-fs/zfs ) )
	|| ( mail-client/thunderbird-bin mail-client/thunderbird )
	net-misc/iperf
	accessibility? ( app-accessibility/espeakup
			app-accessibility/brltty )
	!livecd-stage1? ( drivers? ( sys-kernel/ax88179_178a ) )
	app-crypt/openvpn-blacklist
	app-admin/localepurge
	app-editors/nano
	app-misc/mc
	app-misc/screen
	app-portage/layman
	app-portage/smart-live-rebuild
	media-fonts/dejavu
	media-fonts/font-misc-misc
	dev-vcs/subversion
	media-sound/alsa-utils
	net-dialup/lrzsz
	net-dialup/ppp
	net-firewall/iptables
	|| ( net-fs/mount-cifs net-fs/samba )
	net-misc/dhcp
	net-misc/dhcpcd
	net-misc/vconfig
	|| ( net-misc/wicd net-misc/networkmanager )
	sys-apps/fbset
	sys-apps/sysvinit
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
"

src_install() {
	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-linux_link.start
	newexe "${FILESDIR}"/00-speed_shutdown.stop-r1 00-speed_shutdown.stop
	newexe "${FILESDIR}"/99-power_saving.start-r1 99-power_saving.start
}
