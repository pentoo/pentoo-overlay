# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_virtualbox video_cards_vmware"
IUSE="bindist enlightenment kde livecd livecd-stage1 qemu +windows-compat +X +xfce ${IUSE_VIDEO_CARDS}"

S="${WORKDIR}"

#we now ship all the files in pentoo-system instead so must avoid collisions
DEPEND="!!<pentoo/pentoo-2014.3"

# Things needed for a running system and not for livecd
PDEPEND="livecd? ( pentoo/pentoo-livecd )
	!livecd? ( !pentoo/pentoo-livecd
	!app-misc/livecd-tools )"

# Basic systems
PDEPEND="${PDEPEND}
	qemu? ( app-emulation/virt-manager
		!livecd-stage1? ( sys-apps/usermode-utilities ) )
"
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
	app-arch/sharutils
	app-portage/gentoolkit
	app-portage/eix
	app-portage/porthole
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
	sys-power/hibernate-script
	sys-process/htop
	sys-process/iotop
	sys-apps/openrc[pentoo]
	app-crypt/gnupg
	sys-apps/hdparm
	!arm? ( sys-boot/efibootmgr )
	sys-fs/cryptsetup
	sys-process/lsof
	!arm? ( sys-kernel/pentoo-sources )
	app-portage/mirrorselect
	!livecd-stage1? ( amd64? ( sys-fs/zfs ) )
	app-crypt/openvpn-blacklist
	app-admin/localepurge
	app-editors/nano
	app-misc/mc
	app-misc/screen
	app-portage/layman
	app-portage/smart-live-rebuild
	dev-vcs/subversion
	media-fonts/dejavu
	media-fonts/font-misc-misc
	media-sound/alsa-utils
	net-dialup/lrzsz
	net-dialup/ppp
	net-firewall/iptables
	|| ( net-fs/mount-cifs net-fs/samba )
	net-misc/dhcp
	net-misc/dhcpcd
	net-misc/vconfig
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	net-wireless/iw
	sys-apps/ethtool
	sys-apps/iproute2
	sys-apps/fbset
	sys-apps/sysvinit
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/exfat-utils
	sys-fs/fuse-exfat
	dev-python/ipython
	!bindist? ( X? ( !arm? ( www-plugins/adobe-flash ) ) )
"

src_install() {
	#we don't currently install pentoo.xpm.gz (grubsplash), should we?

	##here is where we merge in things from root_overlay which make sense
	exeinto /root
	newexe "${FILESDIR}"/b43-commercial-2012.1 b43-commercial
	insinto /root
	newins "${FILESDIR}"/motd-${PV} motd

	#/usr/bin
	use enlightenment && newbin "${FILESDIR}"/dokeybindings-2012.1 dokeybindings

	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-${PV} flushchanges
	newsbin "${FILESDIR}"/makemo-${PV} makemo

	#/etc
	insinto /etc
	echo "Pentoo Release ${PV}" > pentoo-release
	doins pentoo-release

	dodir /etc/env.d
	use kde && echo 'XSESSION="KDE-4"' > "${ED}"/etc/env.d/90xsession
	use xfce && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/layman-sync

	dodir /root
	use xfce && echo "exec startxfce4 --with-ck-launch" > "${ED}"/root/.xinitrc

	if [ ! -e "${EROOT}/etc/env.d/02locale" ]
	then
		doenvd "${FILESDIR}"/02locale
	fi

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf

	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-linux_link.start
	newexe "${FILESDIR}"/00-speed_shutdown.stop-r1 00-speed_shutdown.stop
	newexe "${FILESDIR}"/99-power_saving.start-r1 99-power_saving.start
}

pkg_postinst() {
	if [[ "${REPLACING_VERSIONS}" < "2014.2" ]]; then
		ewarn "Wicd has been replaced as the default network manager in favor of the"
		ewarn "significantly more usable networkmanager. It is suggested that you run:"
		ewarn "emerge -C wicd && emerge --oneshot networkmanager"
	fi
}
