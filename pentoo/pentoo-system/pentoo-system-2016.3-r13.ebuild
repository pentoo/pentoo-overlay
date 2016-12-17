# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit mount-boot

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_virtualbox video_cards_vmware"
IUSE="+2fa bindist enlightenment kde livecd livecd-stage1 pax_kernel qemu +windows-compat +X +xfce ${IUSE_VIDEO_CARDS}"

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
	video_cards_vmware? ( !livecd-stage1? ( app-emulation/open-vm-tools ) )
	"

PDEPEND="${PDEPEND}
	!livecd-stage1? ( video_cards_virtualbox? ( app-emulation/virtualbox-guest-additions )
			video_cards_nvidia? ( x11-misc/bumblebee ) )
	app-admin/sudo
	app-shells/bash-completion
	app-portage/portage-utils
	|| ( app-admin/syslog-ng virtual/logger )
	|| ( sys-process/fcron virtual/cron )
	sys-apps/gptfdisk
	sys-apps/pcmciautils
	!arm? ( !livecd-stage1? ( sys-kernel/genkernel
		|| ( sys-boot/grub:0 sys-boot/grub-static sys-boot/grub:2 sys-boot/systemd-boot )
		)
		sys-boot/syslinux
		sys-boot/efibootmgr )
	2fa? ( app-crypt/yubikey-neo-manager
		sys-auth/yubikey-personalization-gui
		sys-auth/pam_yubico )
	app-arch/unrar
	app-arch/unzip
	app-arch/sharutils
	!arm? ( app-portage/cpuid2cpuflags )
	app-portage/gentoolkit
	app-portage/eix
	app-portage/porthole
	windows-compat? ( app-emulation/wine
	dev-python/ipython
	pax_kernel? ( sys-apps/elfix )
	sys-apps/pciutils
	sys-apps/usbutils
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	!arm? ( sys-firmware/intel-microcode )
	net-fs/curlftpfs
	net-fs/sshfs
	sys-kernel/linux-firmware
	sys-libs/gpm
	!arm? ( sys-power/acpid[pentoo] )
	sys-power/hibernate-script
	sys-process/htop
	sys-process/iotop
	sys-apps/openrc
	app-crypt/gnupg
	sys-apps/hdparm
	sys-fs/cryptsetup
	sys-process/lsof
	!arm? ( sys-kernel/pentoo-sources )
	app-portage/mirrorselect
	!livecd-stage1? ( amd64? ( !pax_kernel? ( sys-fs/zfs ) ) )
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
	|| ( net-fs/cifs-utils net-fs/samba )
	net-misc/dhcp
	net-misc/dhcpcd
	net-misc/mosh
	net-misc/vconfig
	net-wireless/bluez
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	net-wireless/iw
	sys-apps/ethtool
	sys-apps/iproute2
	sys-apps/fbset
	sys-apps/sysvinit
	sys-apps/rng-tools
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/exfat-utils
	sys-fs/fuse-exfat
	sys-process/atop
	pax_kernel? ( x11-misc/xdialog )
"

src_install() {
	insinto /boot/grub
	doins "${FILESDIR}"/pentoo.xpm.gz

	if use pax_kernel; then
		dosbin "${FILESDIR}"/toggle_hardened
		exeinto /root/Desktop/
		doexe "${FILESDIR}"/toggle_hardened.desktop
		exeinto /etc/skel/Desktop/
		newexe "${FILESDIR}"/sudo_toggle_hardened.desktop toggle_hardened.desktop
	fi

	##here is where we merge in things from root_overlay which make sense
	exeinto /root
	newexe "${FILESDIR}"/b43-commercial-2016.3 b43-commercial
	exeinto /etc/skel
	newexe "${FILESDIR}"/b43-commercial-2016.3 b43-commercial

	#/usr/bin
	use enlightenment && newbin "${FILESDIR}"/dokeybindings-2012.1 dokeybindings

	#/etc
	insinto /etc
	echo "Pentoo Release ${PV}" > pentoo-release
	doins pentoo-release
	newins "${FILESDIR}"/motd-2016.3-r3 motd
	newins "${FILESDIR}"/issue.pentoo.logo issue.pentoo.logo

	dodir /etc/env.d
	use kde && echo 'XSESSION="KDE-4"' > "${ED}"/etc/env.d/90xsession
	use xfce && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession

	insinto /etc/skel
	newins "${FILESDIR}"/Xdefaults .Xdefaults

	insinto /etc/skel/.config/gtk-3.0/
	newins "${FILESDIR}"/gtk3-settings.ini settings.ini

	insinto /etc/skel/.config/xfce4/terminal/
	doins "${FILESDIR}"/terminalrc

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/layman-sync
	doexe "${FILESDIR}"/ungit

	if [ ! -e "${EROOT}/etc/env.d/02locale" ]
	then
		doenvd "${FILESDIR}"/02locale
	fi

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf

	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-linux_link.start
	newexe "${FILESDIR}"/00-speed_shutdown.stop-r2 00-speed_shutdown.stop
	newexe "${FILESDIR}"/99-power_saving.start-r3 99-power_saving.start

	dosym /var/lib/layman/pentoo/scripts/pentoo-updater.sh /usr/sbin/pentoo-updater
}

pkg_postinst() {
	#needed to handle the grubsplash installation
	mount-boot_pkg_postinst

	if [[ "${REPLACING_VERSIONS}" < "2014.2" ]]; then
		ewarn "Wicd has been replaced as the default network manager in favor of the"
		ewarn "significantly more usable networkmanager. It is suggested that you run:"
		ewarn "emerge -C wicd && emerge --oneshot networkmanager"
	fi
	if [[ "${REPLACING_VERSIONS}" < "2014.3-r3" ]]; then
		#some things meant for QA and testing only slipped through from the build box onto 2014.RC3, so we cleanup here
		if ! use livecd; then
			[ "$(md5sum /etc/portage/profile/package.accept_keywords | awk '{ print $1 }')" = "f3242c20efbc665dafe6119a84461534" ] && rm -f /etc/portage/profile/package.accept_keywords
			[ "$(md5sum /etc/portage/profile/package.mask | awk '{ print $1 }')" = "f7621c2a76772a94db18a561ff5818a0" ] && rm -f /etc/portage/profile/package.mask
			[ "$(md5sum /etc/portage/profile/package.use | awk '{ print $1 }')" = "790bbec66bd20386f4e6f1ef60fe2f44" ] && rm -f /etc/portage/profile/package.use
			[ "$(md5sum /etc/portage/profile/packages | awk '{ print $1 }')" = "e532e65c052971fecaced9704b394a4b" ] && rm -f /etc/portage/profile/packages
			[ "$(md5sum /etc/portage/profile/profile.bashrc | awk '{ print $1 }')" = "fcf650d19150dca21cbf503b4fe055d4" ] && rm -f /etc/portage/profile/profile.bashrc
			[ "$(md5sum /etc/portage/profile/use.mask | awk '{ print $1 }')" = "22474d40439007cc1a5591c120ed8f0f" ] && rm -f /etc/portage/profile/use.mask
			[ "$(md5sum /etc/portage/depcheck | awk '{ print $1 }')" = "9a641fdf877badd5fdbfbcd45d73a222" ] && rm -f /etc/portage/depcheck
			[ "$(md5sum /etc/portage/repos.conf | awk '{ print $1 }')" = "1e1e8a6977e6d2c056cb1223f71d6b07" ] && rm -f /etc/portage/repos.conf
		fi
	fi
}
