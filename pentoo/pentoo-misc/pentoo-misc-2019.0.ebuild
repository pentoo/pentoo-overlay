# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="+accessibility +atm gtk java +office X pentoo-full"

PDEPEND="
	app-arch/p7zip
	net-dns/bind-tools
	net-misc/curl
	net-misc/openssh
	net-misc/stunnel
	net-misc/telnet-bsd
	app-misc/wipe
	net-misc/whois

	accessibility? ( app-accessibility/espeakup
			app-accessibility/brltty )

	X? ( office? ( || ( app-office/libreoffice app-office/libreoffice-bin ) ) )

	pentoo-full? (
		gtk? ( media-video/gtk-recordmydesktop )
		X? ( app-editors/gedit
			app-editors/ghex
			app-editors/sublime-text
			media-sound/alsamixergui
			media-sound/audacious
			net-ftp/gproftpd
			java? ( net-im/jitsi-bin )
			net-im/pidgin
			sys-block/gparted
			net-misc/remmina[rdp]
			net-irc/hexchat
			|| ( mail-client/thunderbird-bin mail-client/thunderbird )
		)
		app-misc/mc
		!arm? ( sys-boot/unetbootin )
		atm? ( net-dialup/linux-atm )
		app-editors/hexedit
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
