# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
KEYWORDS="-*"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd livecd-stage1 hardened dwm +analyzer +bluetooth +cracking +database enlightenment +exploit +footprint +forensics +forging +fuzzers -kde +mitm +proxies qemu -gnome qt4 radio +rce +scanner video_cards_vmware +voip +wireless +xfce"

S="${WORKDIR}"

REQUIRED_USE="xfce? ( !enlightenment )"

DEPEND="hardened? ( sys-apps/paxctl
		    app-misc/pax-utils )"

# Will get merged by fsscript
# pentoo/pentoo-etc-portage
#things needed for a running system and not for livecd
RDEPEND="${RDEPEND}
	!livecd? ( !pentoo/pentoo-livecd
		   !app-misc/livecd-tools
		   pentoo/pentoo-etc-portage
		   sys-kernel/genkernel[pentoo]
		   app-portage/portage-utils
		   app-admin/syslog-ng
		   virtual/cron )"

RDEPEND="${RDEPEND}
	!livecd-stage1? ( video_cards_vmware? ( app-emulation/open-vm-tools ) )"

#system
RDEPEND="${RDEPEND}
	sys-apps/openrc[pentoo]
	dev-util/lafilefixer
	app-arch/sharutils
	app-crypt/gnupg
	sys-apps/hdparm
	sys-fs/cryptsetup
	dev-libs/icu
	sys-process/lsof
	sys-kernel/pentoo-sources
	app-misc/mc
	sys-apps/pcmciautils"

#window makers
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
		x11-apps/xrandr
		media-gfx/geeqie )"

# enlightenment
RDEPEND="${RDEPEND}
	enlightenment? ( =app-misc/exchange-9999
	=dev-libs/eet-9999
	=dev-libs/eeze-9999
	=dev-libs/eina-9999
	=dev-libs/embryo-9999
	=dev-libs/efreet-9999
	=dev-libs/e_dbus-9999
	=dev-libs/ecore-9999
	=media-libs/edje-9999
	=media-libs/emotion-9999
	=media-libs/evas-9999
	=x11-plugins/e_modules-tclock-9999
	=x11-plugins/e_modules-engage-9999
	=x11-plugins/extramenu-9999
	=x11-wm/enlightenment-9999
	x11-apps/xrandr )"

#X windows stuff
RDEPEND="${RDEPEND}
	x11-libs/gksu
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/terminal
	x11-themes/gtk-chtheme"

#basic systems
RDEPEND="${RDEPEND}
	qemu? ( !livecd-stage1? ( app-emulation/virt-manager
				  app-emulation/qemu-kvm ) )
	x86? ( mail-client/thunderbird-bin )
	amd64? ( app-emulation/emul-linux-x86-java )
	www-client/firefox-bin
	dev-java/sun-jdk
	|| ( sys-boot/grub
	sys-boot/grub-static )
	app-admin/genmenu
	app-admin/localepurge
	app-arch/unrar
	app-arch/unzip
	app-editors/ghex
	app-editors/hexedit
	app-editors/nano
	app-editors/gedit
	app-editors/vim
	app-misc/screen
	app-portage/eix
	app-portage/gentoolkit
	app-portage/layman
	app-portage/porthole
	app-portage/smart-live-rebuild
	app-portage/ufed
	app-text/dos2unix
	app-text/evince
	app-text/wgetpaste
	dev-libs/libxslt
	dev-vcs/subversion
	gnome-base/gnome-menus
	media-fonts/dejavu
	media-fonts/font-misc-misc
	media-gfx/fbgrab
	media-gfx/scrot
	media-sound/alsamixergui
	media-sound/alsa-utils
	media-sound/audacious
	media-sound/sox
	media-sound/pulseaudio
	media-sound/pavucontrol
	media-video/vlc
	media-video/xine-ui
	net-dialup/lrzsz
	net-dialup/minicom
	net-dialup/ppp
	net-dialup/wvdial
	net-dns/bind-tools
	|| ( net-fs/mount-cifs
	     net-fs/samba )
	net-firewall/iptables
	net-firewall/firehol
	net-fs/nfs-utils
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
	sys-apps/microcode-ctl
	sys-apps/microcode-data
	sys-apps/pciutils
	sys-apps/mlocate
	sys-apps/usb_modeswitch
	sys-apps/sysvinit
	sys-block/gparted
	sys-boot/syslinux
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/sshfs-fuse
	sys-libs/gpm
	!arm? ( sys-power/acpid[pentoo] )
	sys-power/cpufrequtils
	sys-power/hibernate-script
	sys-power/powertop
	sys-process/htop
	sys-process/iotop
	www-client/links
	www-plugins/adobe-flash
	www-servers/lighttpd
	www-plugins/firecat
	x11-apps/setxkbmap
	x11-apps/xinit"
# FAils:
# 	net-dialup/linux-atm

# Either links or lynx
# 	www-client/lynx
#	qt4? ( net-firewall/fwbuilder )

RDEPEND="${RDEPEND}
	net-analyzer/tcpreplay"

RDEPEND="${RDEPEND}
	app-crypt/openvpn-blacklist
	app-misc/dradis
	amd64? ( net-analyzer/arpantispoofer )
	net-analyzer/netcat6
	net-analyzer/netdiscover
	net-analyzer/ngrep
	net-analyzer/snort
	net-analyzer/tcpdump
	net-analyzer/traceroute
	net-analyzer/wireshark"
# Fails:
#	net-analyzer/packet-o-matic
	#TODO: explain why these aren't included?
	#net-wireless/waveselect
	#dev-db/absinthe very old crap
	#net-analyzer/hydra medus is better
#bug #333099
#	net-analyzer/honeyd

#the tools
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
	proxies? ( pentoo/pentoo-proxies )
	radio? ( pentoo/pentoo-radio )
	rce? ( pentoo/pentoo-rce )
	scanner? ( pentoo/pentoo-scanner )
	voip? ( pentoo/pentoo-voip )
	wireless? ( pentoo/pentoo-wireless )"

pkg_setup() {
	#pam_pwdb and pam_console are no longer supported
	grep -v pam_console "${ROOT}"/etc/pam.d/entrance > "${T}"/entrance
	local grepret=$?
	[ ${grepret} -ge 2 ] && [ -f "${ROOT}"/etc/pam.d/entrance ] && die "Tried to grep the pam files and got an error."
	[ ${grepret} == 0 ] && einfo "pam_console has been purged from /etc/pam.d/entrance. It's a good thing."
	[ ${grepret} == 1 ] && einfo "pam_console was not found in /etc/pam.d/entrance. It's a good thing"
	mv "${T}"/entrance "${ROOT}"/etc/pam.d/entrance
	grep pam_console "${ROOT}/etc/pam.d/*"
	local grepret=$?
	[ ${grepret} == 0 ] && die "pam_console still exists in /etc/pam.d/ and is no longer supported. Please remove all instances of pam_console."
	[ ${grepret} == 1 ] && einfo "pam_console no longer exists in /etc/pam.d. It's a good thing."
	grep pam_pwdb "${ROOT}/etc/pam.d/*"
	local grepret=$?
	[ ${grepret} == 0 ] && die "pam_pwdb still exists in /etc/pam.d/ and is no longer supported. Please remove all instances of pam_pwdb."
	[ ${grepret} == 1 ] && einfo "pam_pwdb no longer exists in /etc/pam.d. It's a good thing."
}

src_install() {
	##here is where we merge in things from root_overlay which make sense
	exeinto /root
	newexe "${FILESDIR}"/b43-commercial-${PV} b43-commercial
	insinto /root
	newins "${FILESDIR}"/motd-${PV} motd

	#/usr/bin
	use enlightenment && newbin "${FILESDIR}"/dokeybindings-${PV} dokeybindings

	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-${PV} flushchanges
	newsbin "${FILESDIR}"/makemo-${PV} makemo

	#/etc
	insinto /etc
	newins "${FILESDIR}/pentoo-release-${PV}-rc2" pentoo-release

	#/etc/portage/postsync.d
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/layman-sync

	#/etc/local.d/
	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-linux_link.start "${FILESDIR}"/00-power_saving.start

	#we will officially support xfce4 OR enlightenment, defaulting to xfce4
	dodir /root
	use enlightenment && echo "exec enlightenment_start" > "${ED}"/root/.xinitrc
	use xfce && echo "exec ck-launch-session startxfce4" > "${ED}"/root/.xinitrc
	use gnome && ewarn "Gnome is officially unsupported, you are on your own"
	use kde && ewarn "KDE is officially unsupported, you are on your own"

	insinto /usr/share/${PN}/wallpaper
	doins "${FILESDIR}"/domo-roolz.jpg
	doins "${FILESDIR}"/tux-winfly-killah.1600x1200.jpg
	doins "${FILESDIR}"/xfce4-desktop.xml
}

pkg_postinst() {
	elog "This ebuild is a meta ebuild to handle all the pentoo specific things which"
	elog "we can't figure out how to handle cleanly.  This will allow us our very own"
	elog "meta-package which can be used to make sure the installed users can be"
	elog "updated when we make fairly major changes.  This may not handle everything,"
	elog "but it is a start..."

	ewarn "Significant changes have been made to your system, you must type 'etc-update'."
	ewarn "This command will help you merge the changed configuration files onto your system."
	epause "Seriously, stop what you are doing now and run 'etc-update'"
}
