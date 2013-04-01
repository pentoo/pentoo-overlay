# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd livecd-stage1 +analyzer bindist +bluetooth +cracking +database +enlightenment +exploit +footprint +forensics +forging +fuzzers -kde +mitm +mobile +proxies qemu -gnome pentoo +radio +rce +scanner +voip +wireless +xfce X"

S="${WORKDIR}"

DEPEND="!pentoo/pentoo-etc-portage"

# Things needed for a running system and not for livecd
PDEPEND="${PDEPEND}
	!livecd? ( !pentoo/pentoo-livecd
		   !app-misc/livecd-tools )"

# Window makers
PDEPEND="${PDEPEND}
	enlightenment? ( x11-wm/enlightenment:0.17
	x11-terms/terminology
	gnome-base/gnome-menus
	=x11-plugins/extramenu-9999 )
	gnome? ( pentoo/pentoo-gnome )
	kde? ( kde-base/kdebase-meta
		kde-base/kate
		kde-base/kcalc
		kde-base/kgpg
		kde-base/kmix
		kde-base/ksnapshot
		kde-misc/networkmanagement
		net-misc/smb4k )
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
PDEPEND="${PDEPEND}
	X? ( net-irc/hexchat
	x11-apps/setxkbmap
	x11-apps/xbacklight
	x11-apps/xdm
	x11-apps/xinit
	x11-apps/xrandr
	x11-libs/gksu
	x11-misc/slim
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/xfce4-terminal
	x11-themes/gtk-theme-switch )
	app-text/evince
	www-plugins/adobe-flash
	www-plugins/firecat
	media-sound/pavucontrol
	media-sound/pulseaudio
	net-misc/rdesktop
	net-misc/tightvnc
	bindist? ( www-client/firefox-bin )
	!bindist? ( || ( www-client/firefox www-client/firefox-bin ) )
	"

# Basic systems
PDEPEND="${PDEPEND}
	qemu? ( !livecd-stage1? ( app-emulation/virt-manager ) )
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
	net-ftp/tftp-hpa
	net-ftp/ftp
	net-ftp/gproftpd
	net-ftp/oftpd
	net-im/pidgin
	net-im/jitsi-bin
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
	net-misc/stunnel
	net-misc/tcpick
	net-misc/telnet-bsd
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
	www-client/links
	www-client/lynx
	www-servers/lighttpd"

# The tools
PDEPEND="${PDEPEND}
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
	newins "${FILESDIR}"/motd-2013.0-r2 motd

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
	doexe "${FILESDIR}"/00-compat-drivers.start
	doexe "${FILESDIR}"/99-power_saving.start

	dodir /root
	echo "exec enlightenment_start" > "${ED}"/root/.xinitrc

	insinto /usr/share/${PN}/wallpaper
	doins "${FILESDIR}"/domo-roolz.jpg
	doins "${FILESDIR}"/tux-winfly-killah.1600x1200.jpg
	doins "${FILESDIR}"/xfce4-desktop.xml
	dosym /usr/share/${PN}/wallpaper/domo-roolz.jpg /usr/share/backgrounds/xfce/domo-roolz.jpg
	dosym /usr/share/${PN}/wallpaper/tux-winfly-killah.1600x1200.jpg /usr/share/backgrounds/xfce/tux-winfly-killah.1600x1200.jpg

	#We support UTF8 here son...
	if [ ! -e "${EROOT}/etc/env.d/02locale" ]
	then
		doenvd "${FILESDIR}"/02locale
	fi

	insinto /etc/fonts
	doins "${FILESDIR}"/local.conf
}
