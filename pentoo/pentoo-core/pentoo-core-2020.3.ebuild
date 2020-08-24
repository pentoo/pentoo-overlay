# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo minimum core requirements"
HOMEPAGE="http://www.pentoo.ch"
SRC_URI="amd64? ( http://dev.pentoo.ch/~zero/distfiles/pentoo-grubtheme.tar.xz )
		x86? ( http://dev.pentoo.ch/~zero/distfiles/pentoo-grubtheme.tar.xz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="livecd pentoo-in-a-container pentoo-minimal"

DEPEND=""
RDEPEND="!<pentoo/pentoo-system-2020.2-r6"
BDEPEND=""

# Things needed for a running system and not for livecd
PDEPEND="livecd? ( pentoo/pentoo-livecd )"

PDEPEND="${PDEPEND}
	app-editors/nano
	app-editors/vim
	app-crypt/gnupg
	app-crypt/openpgp-keys-gentoo-release
	app-portage/gentoolkit
	app-portage/smart-live-rebuild
	net-misc/dhcpcd
	net-wireless/bluez
	net-wireless/iw
	net-wireless/wpa_supplicant
	sys-apps/ethtool
	sys-apps/iproute2
	sys-apps/openrc
	sys-apps/pciutils
	sys-apps/sysvinit
	sys-apps/usbutils
	sys-fs/cryptsetup
	"

#make it even more minimal
PDEPEND="${PDEPEND}
	!pentoo-minimal? (
		app-admin/sudo
		app-misc/screen
		app-portage/eix
		app-portage/mirrorselect
		app-portage/portage-utils
		app-shells/bash-completion
		media-fonts/fira-code
		media-fonts/fira-sans
		media-sound/alsa-utils
		net-dialup/ppp
		net-firewall/iptables
		net-firewall/nftables
		net-misc/dhcp
		net-misc/mosh
		net-misc/vconfig
		sys-apps/elfix
		sys-apps/gptfdisk
		sys-apps/mlocate
		sys-apps/usb_modeswitch
		sys-auth/nss-mdns
		sys-process/htop
		sys-process/lsof
		sys-power/thermald
	)"

#Needed only if not in a container
PDEPEND="${PDEPEND}
	pentoo-in-a-container? (
		app-admin/supervisor
	)
	!pentoo-in-a-container? (
		|| ( app-admin/syslog-ng virtual/logger )
		|| ( sys-process/fcron virtual/cron )
		sys-kernel/linux-firmware
		amd64? (
			sys-apps/bolt
		)
		!arm? (
			sys-firmware/intel-microcode
			sys-kernel/pentoo-sources
			sys-power/acpid[pentoo]
			sys-kernel/genkernel
			|| ( sys-boot/grub[themes] sys-boot/systemd-boot )
			sys-boot/os-prober
			sys-boot/efibootmgr
		)
	)"

S="${WORKDIR}"

src_install() {
	if use amd64 || use x86; then
		insinto /usr/share/grub/themes/
		doins -r pentoo
	fi

	#/etc
	insinto /etc
	echo "Pentoo Release ${PV}" > pentoo-release
	doins pentoo-release
	doins "${FILESDIR}"/motd
	newins "${FILESDIR}"/issue.pentoo.logo issue.pentoo.logo

	#/usr/share/pentoo
	insinto /usr/share/pentoo
	#to make this file
	#gpg --keyserver keyserver.ubuntu.com --recv 4AEE18F83AFDEB23
	#gpg --refresh-keys
	#                     zerochaos-       blshkv           wuodan           linxon           ikelos           gkroon/Obs1d1an  github (merges)
	#gpg --armor --export A5DD1427DD11F94A 273E3E90D1A6294F 2FFAE0AE76B5D696 EBE62DD0CCEAE19E D3CF61546B08277D 394C398C531EFAB0 4AEE18F83AFDEB23 > pentoo-keyring.asc
	doins "${FILESDIR}/pentoo-keyring.asc"

	#/etc/portage/repos.conf
	insinto /etc/portage/repos.conf
	newins "${FILESDIR}/pentoo-r2.conf" pentoo.conf

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

	if ! use pentoo-in-a-container; then
		newinitd "${FILESDIR}"/pentoo-linux-symlinks.initd pentoo-linux-symlinks
		newinitd "${FILESDIR}"/pentoo-powersave.initd pentoo-powersave
		newinitd "${FILESDIR}"/pentoo-zram.initd-r3 pentoo-zram
		newconfd "${FILESDIR}"/pentoo-zram.confd pentoo-zram
	fi
}
