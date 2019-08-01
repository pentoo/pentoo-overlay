# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="+accessibility +atm gtk java +office X pentoo-extra pentoo-full"

PDEPEND="
	app-arch/p7zip
	app-text/dos2unix
	app-text/wgetpaste
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

	pentoo-extra? (
		atm? ( net-dialup/linux-atm )
		X? ( gtk? ( media-video/gtk-recordmydesktop )
			|| ( mail-client/thunderbird-bin mail-client/thunderbird )
		)
		app-misc/mc
		net-irc/irssi
		net-misc/netkit-fingerd
		net-misc/netkit-rsh
	)

	pentoo-full? (
		X? ( app-editors/gedit
			app-editors/ghex
			app-editors/sublime-text
			media-fonts/noto-emoji
			media-sound/alsamixergui
			media-sound/audacious
			net-ftp/gproftpd
			java? ( net-im/jitsi-bin )
			net-im/pidgin
			sys-block/gparted
			net-misc/remmina[rdp]
			net-irc/hexchat
		)
		!arm? ( sys-boot/unetbootin )
		app-editors/hexedit
		app-text/uudeview
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
		net-misc/axel
		net-misc/ifenslave
		net-misc/iperf
		net-misc/iputils
		net-misc/netsed
		|| ( net-misc/ntpsec net-misc/ntp )
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
