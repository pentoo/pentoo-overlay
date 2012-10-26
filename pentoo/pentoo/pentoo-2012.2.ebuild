# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
KEYWORDS="-*"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd livecd-stage1 dwm +analyzer +bluetooth +cracking +database enlightenment +exploit +footprint +forensics +forging +fuzzers -kde +mitm +mobile +proxies qemu -gnome qt4 +radio +rce +scanner video_cards_vmware +voip +wireless +xfce"

S="${WORKDIR}"

REQUIRED_USE="xfce? ( !enlightenment )"

DEPEND="!pentoo/pentoo-etc-portage"

#RDEPEND="${RDEPEND}
#	!livecd-stage1? ( video_cards_vmware? ( app-emulation/open-vm-tools ) )"

# System specific
RDEPEND="${RDEPEND}
	!livecd-stage1? ( amd64? ( sys-fs/zfs ) )
	livecd? (   || ( sys-boot/grub sys-boot/grub-static )
		app-misc/livecd-tools
		dev-libs/icu
		sys-apps/microcode-ctl
		sys-apps/microcode-data
		sys-apps/pciutils
		sys-apps/pcmciautils
		sys-apps/sysvinit
		sys-boot/efibootmgr
		sys-boot/syslinux
		sys-firmware/amd-ucode
		sys-fs/cryptsetup
		sys-fs/jfsutils
		sys-fs/reiser4progs
		sys-fs/reiserfsprogs
		sys-fs/squashfs-tools
		sys-kernel/genkernel
		!arm? ( sys-power/acpid[pentoo] )
		!app-portage/portage-utils
		!app-admin/syslog-ng
		!virtual/cron
	)
	app-arch/lbzip2
	app-arch/sharutils
	app-arch/xz-utils
	app-crypt/gnupg
	app-shells/bash-completion
	sys-apps/hdparm
	sys-apps/openrc[pentoo]
	sys-kernel/pentoo-sources
	sys-process/lsof"

# Window makers
RDEPEND="${RDEPEND}
	dwm? ( x11-wm/dwm )
	kde? ( kde-base/kde-meta )
	gnome? ( pentoo/pentoo-gnome )
	xfce? ( xfce-base/xfce4-meta
		app-editors/leafpad
		app-cdr/xfburn
		xfce-base/thunar
		xfce-extra/xfce4-screenshooter
		xfce-extra/xfce4-power-manager
		xfce-extra/thunar-volman
		xfce-extra/tumbler
		x11-themes/tango-icon-theme
		media-gfx/geeqie )"

# Enlightenment
RDEPEND="${RDEPEND}
	enlightenment? ( x11-wm/enlightenment:0.17
		=x11-plugins/extramenu-9999
		gnome-base/gnome-menus )"

# X windows stuff
RDEPEND="${RDEPEND}
	x11-apps/setxkbmap
	x11-apps/xbacklight
	x11-apps/xinit
	x11-apps/xrandr
	x11-libs/gksu
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/terminal
	x11-themes/gtk-theme-switch"

# Basic systems
RDEPEND="${RDEPEND}
	qemu? ( !livecd-stage1? ( app-emulation/virt-manager ) )
	x86? ( mail-client/thunderbird-bin )
	app-admin/genmenu
	app-admin/localepurge
	app-arch/unrar
	app-arch/unzip
	app-crypt/openvpn-blacklist
	app-editors/gedit
	app-editors/ghex
	app-editors/hexedit
	app-editors/nano
	app-editors/vim
	app-misc/dradis
	app-misc/mc
	app-misc/screen
	app-portage/eix
	app-portage/gentoolkit
	app-portage/layman
	app-portage/mirrorselect
	app-portage/porthole
	app-portage/smart-live-rebuild
	app-portage/ufed
	app-text/dos2unix
	app-text/evince
	app-text/wgetpaste
	dev-libs/libxslt
	dev-vcs/subversion
	media-fonts/dejavu
	media-fonts/font-misc-misc
	media-gfx/fbgrab
	media-gfx/scrot
	media-sound/alsa-utils
	media-sound/alsamixergui
	media-sound/audacious
	media-sound/pavucontrol
	media-sound/pulseaudio
	media-sound/sox
	media-video/vlc
	net-dialup/linux-atm
	net-dialup/lrzsz
	net-dialup/minicom
	net-dialup/ppp
	net-dialup/wvdial
	net-dns/bind-tools
	net-firewall/firehol
	net-firewall/iptables
	|| ( net-fs/mount-cifs net-fs/samba )
	net-fs/nfs-utils
	net-ftp/atftp
	net-ftp/ftp
	net-ftp/gproftpd
	net-ftp/oftpd
	net-im/pidgin
	net-irc/irssi
	net-irc/xchat
	net-misc/axel
	net-misc/curl
	net-misc/dhcp
	net-misc/dhcpcd
	net-misc/grdesktop
	net-misc/ifenslave
	net-misc/iputils
	net-misc/netkit-fingerd
	net-misc/netkit-rsh
	net-misc/netsed
	net-misc/ntp
	net-misc/openssh
	net-misc/openvpn
	net-misc/rdesktop
	net-misc/stunnel
	net-misc/tcpick
	net-misc/telnet-bsd
	net-misc/tightvnc
	net-misc/vconfig
	net-misc/vpnc
	net-misc/whois
	net-misc/wicd
	net-misc/wlan2eth
	sys-apps/ethtool
	sys-apps/fbset
	sys-apps/gptfdisk
	sys-apps/iproute2
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	sys-block/gparted
	sys-boot/unetbootin
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/sshfs-fuse
	sys-libs/gpm
	sys-power/cpufrequtils
	sys-power/hibernate-script
	sys-power/powertop
	sys-process/htop
	sys-process/iotop
	www-client/firefox-bin
	www-client/links
	www-client/lynx
	www-plugins/adobe-flash
	www-plugins/firecat
	www-plugins/google-talkplugin
	www-servers/lighttpd"

# The tools
RDEPEND="${RDEPEND}
	livecd? ( pentoo/pentoo-livecd )
	analyzer? ( pentoo/pentoo-analyzer )
	bluetooth? ( pentoo/pentoo-bluetooth )
	cracking? ( pentoo/pentoo-cracking )
	database? ( pentoo/pentoo-database )
	exploit? ( pentoo/pentoo-exploit )
	footprint? ( pentoo/pentoo-footprint )
	forensics? ( pentoo/pentoo-forensics )
	forging? ( pentoo/pentoo-forging )
	fuzzers? ( pentoo/pentoo-fuzzers )
	mitm? ( pentoo/pentoo-mitm )
	mobile? ( pentoo/pentoo-mobile )
	proxies? ( pentoo/pentoo-proxies )
	radio? ( pentoo/pentoo-radio )
	rce? ( pentoo/pentoo-rce )
	scanner? ( pentoo/pentoo-scanner )
	voip? ( pentoo/pentoo-voip )
	wireless? ( pentoo/pentoo-wireless )"

src_install() {
	##here is where we merge in things from root_overlay which make sense
	exeinto /root
	newexe "${FILESDIR}"/b43-commercial-2012.1 b43-commercial
	insinto /root
	newins "${FILESDIR}"/motd-2012.1 motd

	#/usr/bin
	use enlightenment && newbin "${FILESDIR}"/dokeybindings-2012.1 dokeybindings

	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-${PV} flushchanges
	newsbin "${FILESDIR}"/makemo-${PV} makemo

	#/etc
	insinto /etc
	echo "Pentoo Release ${PV}" > pentoo-release

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/layman-sync

	#/etc/local.d/
	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-linux_link.start
	doexe "${FILESDIR}"/00-speed_shutdown.stop
	doexe "${FILESDIR}"/00-compat-wireless.start
	doexe "${FILESDIR}"/99-power_saving.start

	#we will officially support xfce4 OR enlightenment, defaulting to xfce4
	dodir /root
	use enlightenment && echo "exec enlightenment_start" > "${ED}"/root/.xinitrc
	use xfce && echo "exec ck-launch-session startxfce4" > "${ED}"/root/.xinitrc
	use gnome && ewarn "Gnome is officially unsupported, you are on your own to update .xinitrc"
	use kde && ewarn "KDE is officially unsupported, you are on your own to update .xinitrc"

	insinto /usr/share/${PN}/wallpaper
	doins "${FILESDIR}"/domo-roolz.jpg
	doins "${FILESDIR}"/tux-winfly-killah.1600x1200.jpg
	doins "${FILESDIR}"/xfce4-desktop.xml

	#We support UTF8 here son...
	if [ ! -e "${EROOT}/etc/env.d/02locale" ]
	then
		doenvd "${FILESDIR}"/02locale
	fi

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf
}

pkg_postinst() {
	elog "This ebuild is a meta ebuild to handle all the pentoo specific things which"
	elog "we can't figure out how to handle cleanly.  This will allow us our very own"
	elog "meta-package which can be used to make sure the installed users can be"
	elog "updated when we make fairly major changes.  This may not handle everything,"
	elog "but it is a start..."

	ewarn "Significant changes have been made to your system, you must type 'etc-update'."
	ewarn "This command will help you merge the changed configuration files onto your system."
	ewarn "Seriously, stop what you are doing now and run 'etc-update'"
}
