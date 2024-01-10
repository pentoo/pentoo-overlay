# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo minimum core requirements"
HOMEPAGE="https://www.pentoo.org"
SRC_URI="amd64? ( https://dev.pentoo.org/~zero/distfiles/pentoo-grubtheme.tar.xz )
		x86? ( https://dev.pentoo.org/~zero/distfiles/pentoo-grubtheme.tar.xz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="bluetooth livecd pentoo-in-a-container pentoo-minimal"

# Things needed for a running system and not for livecd
PDEPEND="livecd? ( pentoo/pentoo-livecd )"

PDEPEND="${PDEPEND}
	app-editors/nano
	app-editors/vim
	app-crypt/gnupg
	app-portage/gentoolkit
	app-portage/smart-live-rebuild
	net-misc/dhcpcd
	bluetooth? ( net-wireless/bluez )
	net-wireless/iw
	net-wireless/iwd
	net-wireless/wpa_supplicant
	sec-keys/openpgp-keys-gentoo-release
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
		sys-apps/mlocate
		sys-apps/usb_modeswitch
		sys-auth/nss-mdns
		sys-process/htop
		sys-process/lsof
		!pentoo-in-a-container? (
			sys-apps/gptfdisk
		)
	)"

#Needed only if not in a container
PDEPEND="${PDEPEND}
	pentoo-in-a-container? (
		app-admin/supervisor
	)
	!pentoo-in-a-container? (
		app-admin/sudo
		|| ( app-admin/syslog-ng virtual/logger )
		|| ( sys-process/fcron virtual/cron )
		sys-kernel/linux-firmware
		virtual/linux-sources
		amd64? (
			sys-apps/bolt
		)
		!arm? (
			sys-firmware/intel-microcode
			sys-power/acpid
			sys-power/thermald
			sys-kernel/genkernel
			|| ( sys-boot/grub[themes] )
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
	newins "${FILESDIR}"/motd-2020.3-r1 motd
	newins "${FILESDIR}"/issue.pentoo.logo issue.pentoo.logo

	#/usr/share/pentoo
	insinto /usr/share/pentoo
	#to make this file run "${FILESDIR}"/update_pentoo-keyring while in "${FILESDIR}"
	doins "${FILESDIR}/pentoo-keyring.asc"

	#/etc/portage/repos.conf
	insinto /etc/portage/repos.conf
	newins "${FILESDIR}/pentoo-r2.conf" pentoo.conf

	dobin "${FILESDIR}"/pentoo-updater

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/ungit

	doenvd "${FILESDIR}"/02locale

	use amd64 && doenvd "${FILESDIR}"/99xz-threaded

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf

	if ! use pentoo-in-a-container; then
		newinitd "${FILESDIR}"/pentoo-linux-symlinks.initd pentoo-linux-symlinks
		newinitd "${FILESDIR}"/pentoo-powersave.initd pentoo-powersave
		newinitd "${FILESDIR}"/pentoo-zram.initd-r5 pentoo-zram
		newconfd "${FILESDIR}"/pentoo-zram.confd pentoo-zram
	fi
}

pkg_preinst() {
	# using root this way is wrong and likely doesn't work right with binpkgs
	# maybe install the file always and delete it in pkg_preinst if it exists?
	if [ -e "${ROOT}/etc/env.d/02locale" ]; then
		rm "${ED}/etc/env.d/02locale" || die
	fi
}
