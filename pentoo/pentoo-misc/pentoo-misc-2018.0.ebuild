# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 arm x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="+accessibility +atm gtk java qt4 +office X minipentoo"

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/p7zip
	app-misc/wipe
	net-dns/bind-tools
	net-misc/curl
	net-misc/openssh
	net-misc/stunnel
	net-misc/telnet-bsd
	net-misc/whatmask
	net-misc/whois

	!minipentoo? (
		accessibility? ( app-accessibility/espeakup
				app-accessibility/brltty )
		gtk? ( media-video/gtk-recordmydesktop )
		qt4? ( !gtk? ( media-video/qt-recordmydesktop ) )
		X? ( app-editors/gedit
			office? ( || ( app-office/libreoffice app-office/libreoffice-bin ) )
			app-editors/ghex
			app-editors/sublime-text
			media-sound/alsamixergui
			media-sound/audacious
			net-ftp/gproftpd
			java? ( net-im/jitsi-bin )
			net-im/pidgin
			sys-block/gparted
			net-misc/grdesktop
			net-irc/hexchat
			|| ( mail-client/thunderbird-bin mail-client/thunderbird )
		)
		!arm? ( sys-boot/unetbootin )
		atm? ( net-dialup/linux-atm )
		app-editors/hexedit
		app-editors/vim
		app-misc/dradis
		app-text/dos2unix
		app-text/uudeview
		app-text/wgetpaste
		media-gfx/fbgrab
		media-gfx/scrot
		media-sound/sox
		media-video/vlc
		net-dialup/minicom
		net-dns/dnsmasq
		net-firewall/firehol
		net-fs/nfs-utils
		net-ftp/ftp
		net-ftp/oftpd
		net-ftp/tftp-hpa
		net-irc/irssi
		net-misc/axel
		net-misc/ifenslave
		net-misc/iperf
		net-misc/iputils
		net-misc/netkit-fingerd
		net-misc/netkit-rsh
		net-misc/netsed
		net-misc/ntp
		net-vpn/openvpn
		net-misc/portspoof
		net-misc/tcpick
		net-vpn/vpnc
		net-misc/wlan2eth
		sys-power/powertop
		www-client/links
		www-client/lynx
		www-servers/lighttpd
	)"
