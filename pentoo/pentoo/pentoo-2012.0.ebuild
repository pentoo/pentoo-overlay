# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd hardened dwm +analyzer +bluetooth +cracking +database +enlightenment +exploit +footprint +forensics +forging +fuzzers kde +mitm +proxies qemu gnome qt4 +rce +scanner +voip +wireless xfce"

DEPEND="hardened? ( >=sys-apps/sandbox-2.4
		    sys-apps/paxctl 
		    app-misc/pax-utils )"

#main atoms
RDEPEND="sys-kernel/pentoo-sources"

# Will get merged by fsscript
# pentoo/pentoo-etc-portage 

#System apps
RDEPEND="${RDEPEND}
	sys-apps/openrc[pentoo]
	dev-util/lafilefixer
	app-arch/sharutils
	app-crypt/gnupg[static]
	sys-apps/hdparm
	sys-fs/cryptsetup
	dev-libs/icu"

#window makers
RDEPEND="${RDEPEND}
	dwm? ( x11-wm/dwm )
	kde? ( kde-base/kde-meta )
	gnome? ( pentoo/pentoo-gnome )
	xfce? ( xfce-base/xfce4-meta
		app-editors/leafpad 
		xfce-base/thunar
		xfce-extra/xfce4-power-manager
		xfce-extra/thunar-volman
		xfce-extra/tumbler
		x11-themes/tango-icon-theme )"

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
	=x11-wm/enlightenment-9999 )"

#X windows stuff
RDEPEND="${RDEPEND}
	livecd? ( x11-drivers/xf86-input-keyboard
	x11-drivers/xf86-input-mouse
	x11-drivers/xf86-video-apm
	x11-drivers/xf86-video-ark
	x11-drivers/xf86-video-ati
	x11-drivers/xf86-video-chips
	x11-drivers/xf86-video-cirrus
	x11-drivers/xf86-video-fbdev
	x11-drivers/xf86-video-glint
	x11-drivers/xf86-video-i128
	x11-drivers/xf86-video-intel
	x11-drivers/xf86-video-mach64
	x11-drivers/xf86-video-mga
	x11-drivers/xf86-video-neomagic
	x11-drivers/xf86-video-nv
	x11-drivers/xf86-video-nouveau
	x11-drivers/xf86-video-rendition
	x11-drivers/xf86-video-s3
	x11-drivers/xf86-video-s3virge
	x11-drivers/xf86-video-savage
	x11-drivers/xf86-video-siliconmotion
	x11-drivers/xf86-video-sis
	x11-drivers/xf86-video-tdfx
	x11-drivers/xf86-video-trident
	x11-drivers/xf86-video-vesa
	x11-drivers/xf86-video-vmware
	x11-drivers/xf86-video-voodoo )
	x11-libs/gksu
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/terminal
	x11-themes/gtk-chtheme"

#basic systems
RDEPEND="${RDEPEND}
	livecd? ( <=app-misc/livecd-tools-2.0.0
		virtual/eject
		sys-apps/hwsetup
		sys-block/disktype )
	qemu? ( app-emulation/virt-manager
		app-emulation/qemu-kvm )
	x86? ( mail-client/thunderbird-bin
		www-client/firefox-bin )
	amd64? ( <=www-client/firefox-bin-4.0.0
		 app-emulation/emul-linux-x86-java )
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
	app-portage/smart-live-rebuild
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
	media-video/vlc
	media-video/xine-ui
	net-dialup/lrzsz
	net-dialup/minicom
	net-dialup/ppp
	net-dialup/wvdial
	net-dns/bind-tools
	|| ( net-fs/mount-cifs
	     net-fs/samba )
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
	sys-power/acpid[pentoo]
	sys-power/acpitool
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
	x11-apps/xinit
	x11-misc/mkxf86config"
# FAils:
# 	net-dialup/linux-atm

# Either links or lynx
# 	www-client/lynx
#	qt4? ( net-firewall/fwbuilder )
#	Only in stage2!!!
#	sys-apps/v86d
#	sys-fs/cdfs

RDEPEND="${RDEPEND}
	net-analyzer/tcpreplay"

#things needed for a running system and not for livecd
RDEPEND="${RDEPEND}
	!livecd? ( app-portage/portage-utils
		app-admin/syslog-ng )"

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
	newexe "${FILESDIR}"/b43-commercial-${PV} b43-commercial || die "b43-commercial failed"
	insinto /root
	newins "${FILESDIR}"/motd-${PV} motd || die "motd failed"

	#/usr/bin
	newbin "${FILESDIR}"/dokeybindings-${PV} dokeybindings || die "dokeybindings failed"

	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-${PV} flushchanges || die "flushchanges failed"
	newsbin "${FILESDIR}"/makemo-${PV} makemo || "makemo failed"

	#/etc
	insinto /etc
	newins "${FILESDIR}/pentoo-release-${PV}-rc1" pentoo-release || die "pentoo-release versioning failed"
	exeinto /etc/portage/postsync.d
	doexe "${FILESDIR}"/layman-sync || die "/etc/portage/postsync.d failure"
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
