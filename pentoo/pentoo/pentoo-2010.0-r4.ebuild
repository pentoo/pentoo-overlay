# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="dwm +analyzer +bluetooth +cracking +database +enlightenment +exploit +footprint +forging +fuzzers kde +mitm +proxies +rce +wireless xfce"

DEPEND=""

#main atoms
RDEPEND="=sys-kernel/pentoo-sources-2.6.32-r1"

#things not permitted to exist (due to security holes)
RDEPEND="${RDEPEND}
	!<net-misc/tor-0.2.1.22"

#do we rule the world?
RDEPEND="${RDEPEND}
	sys-apps/pentoo-etc-portage"

#System apps
RDEPEND="${RDEPEND}
	sys-apps/openrc[pentoo]
	dev-util/lafilefixer
	app-arch/sharutils
	app-crypt/gnupg
	sys-apps/hdparm
	sys-power/cpufreqd"

#window makers
RDEPEND="${RDEPEND}
	dwm? ( x11-wm/dwm )
	kde? ( kde-base/kde-meta )
	xfce? ( xfce-base/xfce4-meta 
		app-editors/mousepad )"

# enlightenment
RDEPEND="${RDEPEND}
	enlightenment? ( x11-libs/ecore
	x11-libs/e_dbus
	x11-libs/esmart
	x11-libs/evas
	x11-misc/entrance
	x11-plugins/e_modules-bling
	x11-plugins/e_modules-calendar
	x11-plugins/e_modules-cpu
	x11-plugins/e_modules-language
	x11-plugins/e_modules-mem
	x11-plugins/e_modules-net
	x11-plugins/e_modules-screenshot
	x11-plugins/e_modules-weather
	x11-plugins/e_modules-wlan
	x11-plugins/extramenu
	x11-plugins/itask-ng
	x11-plugins/winlist_ng
	x11-wm/enlightenment )"

#X windows stuff
RDEPEND="${RDEPEND}
	x11-drivers/xf86-input-keyboard
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
	x11-drivers/xf86-video-radeonhd
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
	x11-drivers/xf86-video-voodoo
	x11-libs/gksu
	x11-misc/dmenu
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/terminal
	x11-themes/gtk-chtheme"

#basic systems
RDEPEND="${REDEPEND}
	livecd? ( app-misc/livecd-tools
	sys-apps/eject
	sys-apps/hwsetup
	sys-block/disktype )
	=app-admin/genmenu-9999
	app-admin/localepurge
	app-arch/unrar
	app-arch/unzip
	app-editors/ghex
	app-editors/hexedit
	app-editors/nano
	app-editors/scite
	app-editors/vim
	app-emulation/virt-manager
	app-misc/screen
	app-portage/eix
	app-portage/gentoolkit
	app-portage/layman
	app-text/dos2unix
	app-text/epdfview
	app-text/wgetpaste
	dev-java/sun-jre-bin
	dev-libs/libxslt
	dev-util/ati-stream-sdk-bin
	dev-util/nvidia-cuda-sdk
	dev-util/subversion
	gnome-base/gnome-menus
	mail-client/mozilla-thunderbird-bin
	media-fonts/font-misc-misc
	media-gfx/fbgrab
	media-gfx/scrot
	media-sound/alsamixergui
	media-sound/alsa-utils
	media-sound/audacious
	media-sound/sox
	media-video/vlc
	media-video/xine-ui
	net-dialup/linux-atm
	net-dialup/lrzsz
	net-dialup/minicom
	net-dialup/ppp
	net-dialup/wvdial
	net-dns/bind-tools
	net-firewall/fwbuilder
	net-fs/mount-cifs
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
	x86? ( net-misc/partysip )
	net-misc/rdesktop
	net-misc/sipp
	net-misc/sipsak
	net-misc/stunnel
	net-misc/tcpick
	net-misc/telnet-bsd
	net-misc/tightvnc
	net-misc/voipong
	net-misc/vpnc
	net-misc/whois
	net-misc/wicd
	net-misc/wlan2eth
	sys-apps/fbset
	sys-apps/iproute2
	sys-apps/microcode-ctl
	sys-apps/microcode-data
	sys-apps/pciutils
	sys-apps/slocate
	sys-apps/sysvinit
	sys-apps/v86d
	sys-block/gparted
	sys-boot/grub
	sys-boot/syslinux
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/cdfs
	sys-libs/gpm
	sys-power/acpid
	sys-power/acpitool
	sys-power/hibernate-script
	sys-power/powertop
	sys-process/htop
	www-client/links
	www-client/lynx
	www-client/firefox-bin
	www-plugins/adobe-flash
	www-servers/lighttpd
	x11-plugins/firecat"
	#net-misc/sipbomber
	#net-misc/siproxd

RDEPEND="${RDEPEND}
	net-analyzer/tcpreplay"

RDEPEND="${RDEPEND}
	app-antivirus/malheur
	app-crypt/openvpn-blacklist
	app-misc/dradis
	amd64? ( net-analyzer/arpantispoofer )
	x86? ( net-analyzer/autoscan-network )
	net-analyzer/chaosreader
	net-analyzer/enum4linux
	net-analyzer/etherape
	net-analyzer/firewalk
	net-analyzer/honeyd
	net-analyzer/hunt
	net-analyzer/ike-scan
	net-analyzer/macchanger
	net-analyzer/maketh
	x86? ( net-analyzer/mosref )
	net-analyzer/nbtscan
	net-analyzer/nessus
	net-analyzer/netcat6
	net-analyzer/netdiscover
	net-analyzer/ngrep
	net-analyzer/nikto
	net-analyzer/nmap
	net-analyzer/nmbscan
	net-analyzer/onesixtyone
	net-analyzer/packet-o-matic
	net-analyzer/ppscan
	net-analyzer/scanssh
	net-analyzer/sipvicious
	net-analyzer/snort
	net-analyzer/tcpdump
	net-analyzer/traceroute
	amd64? ( net-analyzer/upnpscan )
	net-analyzer/videojak
	net-analyzer/voiphopper
	net-analyzer/wafp
	net-analyzer/wapiti
	net-analyzer/webshag
	net-analyzer/wireshark
	www-apps/beef"
	#TODO: explain why these aren't included?
	#net-wireless/waveselect
	#dev-db/absinthe
	#net-analyzer/sara
	#net-analyzer/hydra
	#dev-db/sqlinject
	#dev-db/sqlat

#the tools
RDEPEND="${RDEPEND}
	analyzer? ( sys-apps/pentoo-analyzer )
	bluetooth? ( sys-apps/pentoo-bluetooth )
	cracking? ( sys-apps/pentoo-cracking )
	database? ( sys-apps/pentoo-database )
	exploit? ( sys-apps/pentoo-exploit )
	footprint? ( sys-apps/pentoo-footprint )
	forensics? ( sys-apps/pentoo-forensics )
	forging? ( sys-apps/pentoo-forging )
	fuzzers? ( sys-apps/pentoo-fuzzers )
	mitm? ( sys-apps/pentoo-fuzzers )
	proxies? ( sys-apps/pentoo-proxies )
	rce? ( pentoo/pentoo-rce )
	wireless? ( sys-apps/pentoo-wireless )"

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
	newins "${FILESDIR}"/pentoo-release-2010.0-rc1 pentoo-release || die "pentoo-release versioning failed"
	exeinto /etc/portage/postsync.d
	newexe "${FILESDIR}"/layman-sync || die "/etc/portage/postsync.d failure"
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
