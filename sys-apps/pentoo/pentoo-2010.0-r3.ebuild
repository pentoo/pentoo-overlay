# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="One ebuild to rule them all and in the darkness bind them"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="dwm +enlightenment +forensics kde +managedetcportage +sqlsec +webappsec +wirelesssec xfce"

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

#wifi/wireless apps
RDEPEND="${RDEPEND}
	wirelesssec? ( app-crypt/asleap
	net-misc/karma
	net-wireless/gerix
	=net-dialup/freeradius-2.1.7[wpe]
	net-wireless/aircrack-ng
	net-wireless/airoscript
	net-wireless/airpwn
	net-wireless/karmetasploit
	net-wireless/kismet
	net-wireless/mdk
	net-wireless/rfkill
	net-wireless/spectools
	net-wireless/wepattack
	net-wireless/wepdecrypt
	net-wireless/wifi-radar
	net-wireless/wifitap ) "
	#net-wireless/wifiscanner


#window makers
RDEPEND="${RDEPEND}
	dwm? ( x11-wm/dwm )
	enlightenment? ( x11-wm/enlightenment )
	kde? ( kde-base/kde-meta )
	xfce? ( xfce-base/xfce4-meta )"

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
	x11-libs/ecore
	x11-libs/e_dbus
	x11-libs/esmart
	x11-libs/evas
	x11-libs/gksu
	x11-misc/dmenu
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
	x11-plugins/firecat
	x11-plugins/itask-ng
	x11-plugins/pidgin-encryption
	x11-plugins/winlist_ng
	x11-proto/dri2proto
	x11-terms/rxvt-unicode
	x11-terms/terminal
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
	net-misc/iputils
	net-misc/nemesis
	net-misc/netkit-fingerd
	net-misc/netkit-rsh
	net-misc/netsed
	net-misc/ntp
	net-misc/openssh
	net-misc/openvpn
	x86? ( net-misc/partysip )
	net-misc/proxychains
	net-misc/raccess
	net-misc/rdesktop
	net-misc/rdesktop-brute
	net-misc/rsync
	net-misc/sipp
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
	x86? ( net-wireless/intel-wimax-network-service )
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	sys-apps/baselayout
	sys-apps/dcfldd
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
	sys-fs/cdfs
	sys-libs/gpm
	sys-libs/libkudzu
	sys-power/acpid
	sys-power/acpitool
	sys-power/hibernate-script
	sys-power/powertop
	sys-process/htop
	www-client/links
	www-client/lynx
	www-client/mozilla-firefox-bin
	www-plugins/adobe-flash
	www-servers/lighttpd"
	#net-misc/ipsorcery
	#net-misc/sipbomber
	#net-misc/siproxd

#the tools
RDEPEND="${RDEPEND}
	forensics? (
	app-crypt/xor-analyze
	app-forensics/autopsy
	app-forensics/cmospwd
	x86? ( app-forensics/galleta )
	app-forensics/make-pdf
	app-forensics/memdump
	app-forensics/origami
	x86? ( app-forensics/pasco )
	app-forensics/pdfid
	app-forensics/pdf-parser
	app-forensics/sleuthkit )"

RDEPEND="${RDEPEND}
	app-crypt/SIPcrack
	app-crypt/chntpw
	app-crypt/johntheripper
	x86? ( app-crypt/md5bf )
	app-crypt/openvpn-blacklist
	app-crypt/ophcrack
	x86? ( app-fuzz/Peach )
	x86? ( app-fuzz/bed )
	x86? ( app-fuzz/bss )
	x86? ( app-fuzz/fusil )
	x86? ( app-fuzz/fuzzer-server )
	x86? ( app-fuzz/http-fuzz )
	x86? ( app-fuzz/ohrwurm )
	x86? ( app-fuzz/smtp-fuzz )
	x86? ( app-fuzz/smudge )
	x86? ( app-fuzz/taof )
	dev-db/minimysqlator
	dev-db/mssqlscan
	dev-db/oat
	x86? ( dev-db/sqid )
	dev-db/sqlbf
	dev-db/sqlibf
	dev-db/sqlix
	dev-db/sqlmap
	dev-db/sqlninja
	net-analyzer/aimsniff
	net-analyzer/amap
	x86? ( net-analyzer/angst )
	net-analyzer/arpwatch
	net-analyzer/authforce
	x86? ( net-analyzer/autoscan-network )
	net-analyzer/chaosreader
	net-analyzer/dnsa
	net-analyzer/dnsenum
	net-analyzer/dsniff
	net-analyzer/etherape
	net-analyzer/ettercap
	net-analyzer/fasttrack
	net-analyzer/fierce
	net-analyzer/firewalk
	net-analyzer/fragroute
	x86? ( net-analyzer/ftester )
	net-analyzer/geoedge
	net-analyzer/gspoof
	net-analyzer/honeyd
	net-analyzer/hping
	net-analyzer/hunt
	net-analyzer/ike-scan
	net-analyzer/inguma
	net-analyzer/isic
	net-analyzer/macchanger
	net-analyzer/mbrowse
	net-analyzer/medusa
	net-analyzer/metacoretex-ng
	net-analyzer/metagoofil
	net-analyzer/metasploit
	x86? ( net-analyzer/mosref )
	net-analyzer/nbtscan
	net-analyzer/nessus
	net-analyzer/netcat6
	net-analyzer/netdiscover
	net-analyzer/netwag
	net-analyzer/netwox
	net-analyzer/ngrep
	net-analyzer/nikto
	net-analyzer/nmap
	net-analyzer/nmbscan
	net-analyzer/ntop
	net-analyzer/ntp-fingerprint
	net-analyzer/onesixtyone
	net-analyzer/p0f
	net-analyzer/packet-o-matic
	net-analyzer/packit
	net-analyzer/paketto
	net-analyzer/ppscan
	net-analyzer/rain
	net-analyzer/scanssh
	net-analyzer/siphon
	net-analyzer/sipvicious
	x86? ( net-analyzer/smtpmap )
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
	amd64? ( net-analyzer/upnpscan )
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
	x86? ( net-proxy/httpush )
	net-proxy/privoxy-tor
	net-proxy/proxystrike
	net-proxy/tsocks
	net-wireless/b43-openfwwf
	x86? ( net-wireless/bluemaho )
	net-wireless/btscanner
	net-wireless/cowpatty
	net-wireless/crda
	net-wireless/hostapd"
	#net-wireless/waveselect
	#dev-db/absinthe
	#net-analyzer/sara
	#net-analyzer/netdude
	#net-analyzer/hydra
	#net-analyzer/driftnet
	#dev-db/sqlinject
	#dev-db/sqlat

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
	insinto /etc
	newins "${FILESDIR}"/pentoo-release-2010.0-rc1 pentoo-release
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
