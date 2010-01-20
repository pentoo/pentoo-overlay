# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit subversion
KEYWORDS=""
DESCRIPTION="One ebuild to rule them all and in the darkness bind them"
HOMEPAGE="http://www.pentoo.ch"
ESVN_REPO_URI="https://www.pentoo.ch/svn/livecd/trunk/portage/"
SLOT="0"
LICENSE="GPL"
IUSE="dwm +enlightenment kde livecd +wireless xfce"

DEPEND=""

#main atoms
RDEPEND="=sys-kernel/pentoo-sources-2.6.31-r3"

#System apps
RDEPEND="${RDEPEND}
	sys-apps/openrc[pentoo]
	dev-util/lafilefixer
	app-arch/sharutils
	app-crypt/gnupg
	sys-apps/hdparm"

#wifi/wireless apps
RDEPEND="${RDEPEND}
	wireless? ( net-misc/karma
	net-wireless/gerix
	=net-dialup/freeradius-2.1.7[wpe]
	#net-wireless/afrag
	net-wireless/aircrack-ng
	net-wireless/airoscript
	net-wireless/airpwn
	net-wireless/karmetasploit
	net-wireless/kismet
	net-wireless/mdk
	net-wireless/rfkill
	#net-wireless/ska
	net-wireless/spectools
	net-wireless/wepattack
	net-wireless/wepdecrypt
	net-wireless/wifi-radar
	#net-wireless/wifiscanner
	net-wireless/wifitap ) "


#window makers
RDEPEND="${RDEPEND}
	dwm? ( x11-wm/dwm )
	enlightenment? ( x11-wm/enlightenment )
	kde? ( kde-base/kde-meta )
	xfce? ( xfce-base/xfce4-meta )"

#X windows stuff
RDEPEND="${RDEPEND}
	#x11-drivers/xf86-input-evdev
	x11-drivers/xf86-input-keyboard
	x11-drivers/xf86-input-mouse
	#x11-drivers/xf86-input-virtualbox
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
	#x11-drivers/xf86-video-openchrome
	#x11-drivers/xf86-video-r128
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
	#x11-drivers/xf86-video-virtualbox
	x11-drivers/xf86-video-vmware
	x11-drivers/xf86-video-voodoo
	x11-libs/ecore
	x11-libs/e_dbus
	x11-libs/esmart
	x11-libs/evas
	x11-libs/gksu
	#x11-libs/gtk+
	x11-misc/dmenu
	x11-misc/entrance
	#x11-plugins/e_modules
	x11-plugins/e_modules-bling
	x11-plugins/e_modules-calendar
	x11-plugins/e_modules-cpu
	x11-plugins/e_modules-language
	x11-plugins/e_modules-mem
	x11-plugins/e_modules-net
	#x11-plugins/e_modules-notification
	x11-plugins/e_modules-screenshot
	x11-plugins/e_modules-weather
	x11-plugins/e_modules-wlan
	x11-plugins/extramenu
	x11-plugins/firecat
	x11-plugins/itask-ng
	x11-plugins/pidgin-encryption
	x11-plugins/winlist_ng
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-themes/gtk-chtheme"

#basic systems
RDEPEND="${REDEPEND}
	app-admin/gamin
	=app-admin/genmenu-9999
	app-admin/localepurge
	app-admin/syslog-ng
	app-arch/gzip
	app-arch/unrar
	app-arch/unzip
	app-editors/ghex
	app-editors/hexedit
	app-editors/nano
	app-editors/scite
	app-editors/vim
	app-emulation/virt-manager
	app-misc/livecd-tools
	app-misc/screen
	app-mobilephone/obexftp
	app-portage/eix
	app-portage/gentoolkit
	app-portage/layman
	app-text/dos2unix
	app-text/epdfview
	app-text/wgetpaste
	dev-java/jad-bin
	dev-java/sun-jre-bin
	dev-lang/nasm
	dev-libs/klibc
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/openobex
	#dev-python/psyco
	dev-python/pysqlite
	dev-util/ati-stream-sdk-bin
	dev-util/dialog
	dev-util/edb
	dev-util/nvidia-cuda-sdk
	dev-util/radare
	dev-util/strace
	dev-util/subversion
	gnome-base/gnome-menus
	mail-client/mozilla-thunderbird-bin
	media-fonts/font-misc-misc
	media-gfx/scrot
	media-sound/alsamixergui
	media-sound/alsa-utils
	media-sound/audacious
	media-sound/sox
	media-video/vlc
	net-dialup/linux-atm
	net-dialup/lrzsz
	net-dialup/minicom
	net-dialup/ppp
	net-dns/bind-tools
	net-firewall/fwbuilder
	net-fs/mount-cifs
	net-fs/nfs-utils
	net-fs/winexe
	net-ftp/ftp
	net-ftp/gproftpd
	net-ftp/oftpd
	net-im/pidgin
	net-irc/irssi
	net-irc/xchat
	net-misc/axel
	net-misc/bridge-utils
	net-misc/curl
	net-misc/dhcp
	net-misc/dhcpcd
	net-misc/grdesktop
	#net-misc/ipsorcery
	net-misc/iputils
	net-misc/nemesis
	net-misc/netkit-fingerd
	net-misc/netkit-rsh
	net-misc/netsed
	net-misc/ntp
	net-misc/openssh
	net-misc/openvpn
	#net-misc/partysip
	net-misc/proxychains
	net-misc/raccess
	net-misc/rdesktop
	net-misc/rdesktop-brute
	net-misc/rsync
	#net-misc/sipbomber
	net-misc/sipp
	#net-misc/siproxd
	net-misc/sipsak
	net-misc/socat
	net-misc/stunnel
	net-misc/tcpick
	net-misc/telnet-bsd
	net-misc/tightvnc
	net-misc/voipong
	net-misc/vpnc
	net-misc/wget
	net-misc/whois
	net-misc/wicd
	net-misc/wlan2eth
	net-wireless/broadcom-firmware-downloader
	#net-wireless/intel-wimax-network-service
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	sys-apps/baselayout
	sys-apps/eject
	sys-apps/hwsetup
	sys-apps/iproute2
	sys-apps/less
	sys-apps/microcode-ctl
	sys-apps/microcode-data
	sys-apps/pciutils
	sys-apps/portage
	sys-apps/slocate
	sys-apps/sysvinit
	sys-apps/v86d
	sys-block/disktype
	sys-block/gparted
	sys-boot/grub
	sys-boot/syslinux
	sys-devel/crossdev
	sys-devel/gdb
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/udev
	sys-libs/gpm
	sys-libs/libkudzu
	sys-power/acpid
	sys-power/acpitool
	sys-power/powertop
	sys-process/htop
	www-client/links
	www-client/lynx
	www-client/mozilla-firefox-bin
	www-plugins/adobe-flash
	www-servers/lighttpd"

#the tools
RDEPEND="${RDEPEND}
	app-crypt/SIPcrack
	app-crypt/asleap
	app-crypt/chntpw
	app-crypt/johntheripper
	#app-crypt/md5bf
	app-crypt/openvpn-blacklist
	app-crypt/ophcrack
	app-forensics/autopsy
	app-forensics/cmospwd
	#app-forensics/galleta
	#app-forensics/pasco
	app-forensics/sleuthkit
	#app-fuzz/Peach
	#app-fuzz/bed
	#app-fuzz/bss
	#app-fuzz/fusil
	#app-fuzz/fuzzer-server
	#app-fuzz/http-fuzz
	#app-fuzz/ohrwurm
	#app-fuzz/smtp-fuzz
	#app-fuzz/smudge
	#app-fuzz/taof
	#dev-db/absinthe
	dev-db/minimysqlator
	dev-db/mssqlscan
	dev-db/oat
	#dev-db/sqid
	#dev-db/sqlat
	dev-db/sqlbf
	dev-db/sqlibf
	#dev-db/sqlinject
	dev-db/sqlix
	dev-db/sqlmap
	dev-db/sqlninja
	net-analyzer/aimsniff
	net-analyzer/amap
	#net-analyzer/angst
	net-analyzer/arpwatch
	net-analyzer/authforce
	#net-analyzer/autoscan-network
	net-analyzer/chaosreader
	net-analyzer/dnsa
	net-analyzer/dnsenum
	#net-analyzer/driftnet
	net-analyzer/dsniff
	net-analyzer/etherape
	net-analyzer/ettercap
	net-analyzer/fasttrack
	net-analyzer/fierce
	net-analyzer/firewalk
	net-analyzer/fragroute
	#net-analyzer/ftester
	net-analyzer/geoedge
	net-analyzer/gspoof
	net-analyzer/honeyd
	net-analyzer/hping
	net-analyzer/hunt
	#net-analyzer/hydra
	net-analyzer/ike-scan
	net-analyzer/inguma
	net-analyzer/isic
	net-analyzer/macchanger
	net-analyzer/mbrowse
	net-analyzer/medusa
	#net-analyzer/metacoretex-ng saving space...
	net-analyzer/metagoofil
	net-analyzer/metasploit
	#net-analyzer/mosref
	net-analyzer/nbtscan
	net-analyzer/nessus
	net-analyzer/netcat6
	net-analyzer/netdiscover
	#net-analyzer/netdude
	net-analyzer/netwag
	net-analyzer/netwox
	net-analyzer/ngrep
	net-analyzer/nikto
	net-analyzer/nmap
	#net-analyzer/nmbscan needs samba
	net-analyzer/ntop
	net-analyzer/ntp-fingerprint
	net-analyzer/onesixtyone
	net-analyzer/p0f
	net-analyzer/packet-o-matic
	net-analyzer/packit
	net-analyzer/paketto
	net-analyzer/ppscan
	net-analyzer/rain
	#net-analyzer/sara
	net-analyzer/scanssh
	net-analyzer/siphon
	net-analyzer/sipvicious
	#net-analyzer/smtpmap
	net-analyzer/sniffit
	net-analyzer/snmpenum
	net-analyzer/snort
	net-analyzer/sslsniff
	net-analyzer/sslstrip
	net-analyzer/subdomainer
	net-analyzer/tcpdump
	net-analyzer/tcptraceroute
	net-analyzer/thcrut
	net-analyzer/theHarvester
	net-analyzer/traceroute
	net-analyzer/upnpscan
	net-analyzer/videojak
	net-analyzer/voiphopper
	net-analyzer/w3af
	net-analyzer/wapiti
	net-analyzer/webshag
	net-analyzer/wfuzz
	net-analyzer/wireshark
	net-analyzer/xprobe
	net-analyzer/yersinia
	net-proxy/3proxy
	net-proxy/burpsuite
	#net-proxy/httpush
	net-proxy/privoxy-tor
	net-proxy/proxystrike
	net-proxy/tsocks
	net-wireless/b43-openfwwf
	#net-wireless/bluemaho
	net-wireless/btscanner
	net-wireless/cowpatty
	net-wireless/crda
	net-wireless/hostapd
	#net-wireless/waveselect"

pkg_setup() {
	#We clean up old mistakes here, don't add as a blocker
	grep -v 'x11-base/xorg-x11' /var/lib/portage/world > /var/lib/portage/world.cleansed
	local grepret=$?
	[ ${grepret} -ge 2 ] && [ -f ${ROOT}/var/lib/portage/world ] && die "Tried to grep the world file and got an error."
	[ ${grepret} == 0 ] && einfo "x11-base/xorg-x11 has been purged from world. It's a good thing."
	[ ${grepret} == 1 ] && einfo "x11-base/xorg-x11 was found not in the world file. It's a good thing."
	mv /var/lib/portage/world.cleansed /var/lib/portage/world || die "Fixing world failed"
}

src_install() {
	if ! use livecd; then
                insinto /etc/portage/
                doins -r "${S}"/* || die "/etc/portage failed!"
	fi

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
	insinto /etc
	newins "${FILESDIR}"/pentoo-release-2010.0-rc1 pentoo-release
}

pkg_postinst() {
	if [ ! -e "${ROOT}"/etc/portage/package.keywords/user-keywords ]; then
		cp "${FILESDIR}"/user-keywords "${ROOT}"/etc/portage/package.keywords/user-keywords || die "Copy failed, blame Zero"
	fi

	elog "This ebuild is a meta ebuild to handle all the pentoo specific things which"
	elog "we can't figure out how to handle cleanly.  This will allow us our very own"
	elog "meta-package which can be used to make sure the installed users can be"
	elog "updated when we make fairly major changes.  This may not handle everything,"
	elog "but it is a start..."
}
