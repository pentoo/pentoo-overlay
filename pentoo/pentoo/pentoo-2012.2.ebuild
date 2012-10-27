# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
KEYWORDS="-*"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd livecd-stage1 dwm +analyzer +bluetooth +cracking +database enlightenment +exploit +footprint +forensics +forging +fuzzers -kde +mitm +mobile +proxies qemu -gnome qt4 pentoo +radio +rce +scanner video_cards_vmware +voip +wireless +xfce +X"

S="${WORKDIR}"

REQUIRED_USE="xfce? ( !enlightenment )"

DEPEND="!pentoo/pentoo-etc-portage"

# Things needed for a running system and not for livecd
RDEPEND="${RDEPEND}
	!livecd? ( !pentoo/pentoo-livecd
		   !app-misc/livecd-tools
		   app-portage/portage-utils
		   app-admin/syslog-ng
		   virtual/cron )"

#RDEPEND="${RDEPEND}
#	!livecd-stage1? ( video_cards_vmware? ( app-emulation/open-vm-tools ) )"

# Window makers
RDEPEND="${RDEPEND}
	enlightenment? ( x11-wm/enlightenment:0.17
	gnome-base/gnome-menus
	=x11-plugins/extramenu-9999 )
	dwm? ( x11-wm/dwm )
	gnome? ( pentoo/pentoo-gnome )
	kde? ( kde-base/kde-meta )
	xfce? ( xfce-base/xfce4-meta
		app-cdr/xfburn
		app-editors/leafpad
		media-gfx/geeqie
		x11-themes/tango-icon-theme
		xfce-base/thunar
		xfce-extra/thunar-volman
		xfce-extra/tumbler
		xfce-extra/xfce4-power-manager
		xfce-extra/xfce4-screenshooter )"
#	=x11-plugins/e_modules-tclock-9999
#	=x11-plugins/e_modules-engage-9999

#X windows stuff
RDEPEND="${RDEPEND}
	X? ( net-irc/xchat
	x11-apps/setxkbmap
	x11-apps/xbacklight
	x11-apps/xinit
	x11-apps/xrandr
	x11-libs/gksu
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/terminal
	x11-themes/gtk-theme-switch )"

# Basic systems
RDEPEND="${RDEPEND}
	qemu? ( !livecd-stage1? ( app-emulation/virt-manager ) )
	x86? ( mail-client/thunderbird-bin )
	app-admin/genmenu
	app-admin/localepurge
	app-crypt/openvpn-blacklist
	app-editors/gedit
	app-editors/ghex
	app-editors/hexedit
	app-editors/nano
	app-editors/vim
	app-misc/dradis
	app-misc/mc
	app-misc/screen
	app-portage/layman
	app-portage/smart-live-rebuild
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
	sys-apps/iproute2
	sys-apps/sysvinit
	sys-block/gparted
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	www-client/firefox-bin
	www-client/links
	www-client/lynx
	www-plugins/adobe-flash
	www-plugins/firecat
	www-plugins/google-talkplugin
	www-servers/lighttpd"

# The tools
RDEPEND="${RDEPEND}
	analyzer? ( pentoo/pentoo-analyzer )
	bluetooth? ( pentoo/pentoo-bluetooth )
	cracking? ( pentoo/pentoo-cracking )
	database? ( pentoo/pentoo-database )
	exploit? ( pentoo/pentoo-exploit )
	footprint? ( pentoo/pentoo-footprint )
	forensics? ( pentoo/pentoo-forensics )
	forging? ( pentoo/pentoo-forging )
	fuzzers? ( pentoo/pentoo-fuzzers )
	livecd? ( pentoo/pentoo-livecd )
	mitm? ( pentoo/pentoo-mitm )
	mobile? ( pentoo/pentoo-mobile )
	pentoo? ( pentoo/pentoo-system )
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
