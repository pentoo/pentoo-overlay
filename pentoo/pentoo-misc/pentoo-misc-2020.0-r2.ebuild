# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="+accessibility +atm cups gtk java +office X pentoo-extra pentoo-full"

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
		X? ( app-editors/sublime-text
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
		net-ftp/tftp-hpa
		net-misc/axel
		net-misc/ifenslave
		net-misc/iperf
		net-misc/iputils
		net-misc/netsed
		|| ( net-misc/ntpsec net-misc/ntp )
		cups? ( net-print/foomatic-db )
		net-misc/portspoof
		net-misc/tcpick
		net-vpn/vpnc
		net-misc/wlan2eth
		net-vpn/openvpn
		sys-power/powertop
		www-client/links
		www-client/lynx
		www-servers/lighttpd
	)"

#pentoo-full, X?
#			amd64? ( media-fonts/noto-emoji )
