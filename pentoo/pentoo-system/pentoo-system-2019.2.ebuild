# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

#inherit mount-boot

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/pentoo-grubtheme.tar.xz"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_virtualbox video_cards_vmware"
IUSE="+2fa livecd livecd-stage1 pax_kernel pentoo-extra pentoo-full qemu windows-compat +X ${IUSE_VIDEO_CARDS}"

S="${WORKDIR}"

#we now ship all the files in pentoo-system instead so must avoid collisions
DEPEND="!!<pentoo/pentoo-2014.3"

#remove things which conflict with how we are doing things
RDEPEND="!app-portage/porthole"

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
	!livecd-stage1? (
			video_cards_virtualbox? ( !pax_kernel? ( app-emulation/virtualbox-guest-additions ) )
			video_cards_nvidia? ( x11-misc/bumblebee x11-misc/primus ) )
	app-admin/sudo
	app-crypt/openpgp-keys-gentoo-release
	app-shells/bash-completion
	app-portage/portage-utils
	|| ( app-admin/syslog-ng virtual/logger )
	|| ( sys-process/fcron virtual/cron )
	!arm? ( !livecd-stage1? ( || ( sys-kernel/genkernel sys-kernel/genkernel-next )
		|| ( sys-boot/grub:2 sys-boot/systemd-boot )
		)
		sys-boot/os-prober
		sys-boot/syslinux
		sys-boot/efibootmgr )
	2fa? ( app-crypt/yubikey-manager-qt
		sys-auth/yubikey-personalization-gui
		sys-auth/pam_yubico )
	!arm? ( app-portage/cpuid2cpuflags )
	app-portage/gentoolkit
	app-portage/eix
	windows-compat? ( app-emulation/wine-vanilla )
	pax_kernel? ( sys-apps/elfix )
	sys-auth/nss-mdns
	sys-apps/pciutils
	sys-apps/usbutils
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	!arm? ( sys-firmware/intel-microcode )
	sys-kernel/linux-firmware
	!arm? ( sys-power/acpid[pentoo] )
	sys-power/thermald
	sys-process/htop
	sys-apps/openrc
	app-crypt/gnupg
	sys-fs/cryptsetup
	sys-process/lsof
	!arm? ( sys-kernel/pentoo-sources )
	app-portage/mirrorselect
	app-editors/nano
	app-editors/vim
	app-misc/screen
	app-portage/smart-live-rebuild
	media-sound/alsa-utils
	net-dialup/ppp
	net-firewall/iptables
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
	sys-apps/sysvinit
	sys-devel/gettext
	livecd? ( sys-fs/squashfs-tools sys-fs/btrfs-progs )
	pentoo-extra? (
		sys-apps/pcmciautils
		sys-fs/jfsutils
		sys-fs/reiser4progs
		sys-fs/reiserfsprogs
		sys-process/atop
		x11-libs/libdlo
	)
	pentoo-full? (
		app-arch/unrar
		app-arch/unzip
		app-arch/sharutils
		dev-python/ipython
		net-fs/curlftpfs
		net-fs/sshfs
		sys-libs/gpm
		sys-power/hibernate-script
		sys-process/iotop
		sys-apps/hdparm
		app-crypt/openvpn-blacklist
		dev-util/vbindiff
		dev-vcs/subversion
		media-fonts/dejavu
		media-fonts/font-misc-misc
		media-fonts/wqy-zenhei
		media-fonts/wqy-microhei
		sys-apps/rng-tools
		sys-apps/fbset
		net-dialup/lrzsz
		|| ( net-fs/cifs-utils net-fs/samba )
		amd64? ( sys-apps/fwts )
		x86? ( sys-devel/crossdev )
		sys-fs/squashfs-tools
		sys-fs/exfat-utils
		sys-fs/f2fs-tools
		sys-fs/fuse-exfat
		sys-fs/btrfs-progs
		)
"

PDEPEND="${PDEPEND}
	X? ( sys-apps/gptfdisk
		pax_kernel? ( x11-misc/xdialog )
	)"

src_install() {
	insinto /usr/share/grub/themes/
	doins -r pentoo

	if use pax_kernel; then
		dosbin "${FILESDIR}"/toggle_hardened
		exeinto /root/Desktop/
		doexe "${FILESDIR}"/toggle_hardened.desktop
		exeinto /etc/skel/Desktop/
		newexe "${FILESDIR}"/sudo_toggle_hardened.desktop toggle_hardened.desktop
	fi

	#/etc
	insinto /etc
	echo "Pentoo Release ${PV}" > pentoo-release
	doins pentoo-release
	newins "${FILESDIR}"/motd-2018.1 motd
	newins "${FILESDIR}"/issue.pentoo.logo issue.pentoo.logo

	#/usr/share/pentoo
	insinto /usr/share/pentoo
	#to make this file
	#gpg --keyserver keyserver.ubuntu.com --recv 4AEE18F83AFDEB23
	#                     zerochaos-       blshkv           wuodan           linxon           ikelos           github (merges)
	#gpg --armor --export A5DD1427DD11F94A 273E3E90D1A6294F 2FFAE0AE76B5D696 EBE62DD0CCEAE19E D3CF61546B08277D 4AEE18F83AFDEB23 > pentoo-keyring.asc
	doins "${FILESDIR}/pentoo-keyring.asc"

	#/etc/portage/repos.conf
	insinto /etc/portage/repos.conf
	doins "${FILESDIR}/pentoo.conf"

    dobin "${FILESDIR}"/pentoo-updater

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/ungit

	if [ ! -e "${EROOT}/etc/env.d/02locale" ]
	then
		doenvd "${FILESDIR}"/02locale
	fi

	use amd64 && doenvd "${FILESDIR}"/99xz-threaded

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf

	newinitd "${FILESDIR}"/pentoo-linux-symlinks.initd pentoo-linux-symlinks
	newinitd "${FILESDIR}"/pentoo-powersave.initd pentoo-powersave
	newinitd "${FILESDIR}"/pentoo-zram.initd-r3 pentoo-zram
	newconfd "${FILESDIR}"/pentoo-zram.confd pentoo-zram

}

pkg_postinst() {
	if [[ "${REPLACING_VERSIONS}" < "2018.0-r8" ]]; then
		#finally removing the local.d crap and making real pentoo services
		einfo 'You likely want to run "rc-update add pentoo-linux-symlinks default" to migrate to the new symlink fixer.'
		einfo 'Check out the new /etc/init.d/pentoo-* services and enable the ones you want.'
	fi
	if [ -x /usr/bin/layman ]; then
		if /usr/bin/layman -l | grep pentoo; then
			echo "We no longer use layman to control pentoo, please run the following:"
			echo "/usr/bin/layman --delete pentoo && emerge --sync"
		fi
	fi
}
