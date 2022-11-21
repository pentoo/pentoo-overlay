# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="accessibility atm cups gtk java +office pentoo-extra pentoo-full upstream-bins X"

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

	accessibility? (
			|| ( app-accessibility/espeak-ng app-accessibility/espeakup )
			app-accessibility/brltty
			)

	X? ( office? ( || ( app-office/libreoffice app-office/libreoffice-bin ) ) )

	pentoo-full? (
		X? ( app-editors/sublime-text
			media-sound/audacious
			java? ( net-im/jitsi )
			net-im/pidgin
			sys-block/gparted
			net-misc/remmina[rdp]
			net-irc/hexchat
		)
		!arm? ( sys-boot/unetbootin )
		app-editors/hexedit
		app-text/uudeview
		amd64? ( app-admin/awscli )
		media-gfx/fbgrab
		media-gfx/scrot
		media-sound/sox
		media-video/vlc
		net-dialup/minicom
		net-dns/dnsmasq
		net-dns/unbound
		net-firewall/firehol
		net-fs/nfs-utils
		net-ftp/ftp
		net-ftp/tftp-hpa
		net-misc/axel
		net-misc/ifenslave
		net-misc/iperf
		net-misc/iputils
		net-misc/netsed
		net-misc/ntp
		cups? ( net-print/foomatic-db )
		net-misc/portspoof
		net-misc/wlan2eth
		net-vpn/openvpn
		net-vpn/networkmanager-openvpn
		net-vpn/vpnc
		net-vpn/networkmanager-vpnc
		net-vpn/wireguard-tools
		amd64? ( sys-power/intel-undervolt )
		sys-power/powertop
		www-client/links
		www-client/lynx
		www-servers/lighttpd
	)

	pentoo-extra? (
		atm? ( net-dialup/linux-atm )
		X? ( gtk? ( media-video/obs-studio )
			upstream-bins? ( mail-client/thunderbird-bin )
			!upstream-bins? ( mail-client/thunderbird )
		)
		app-containers/docker
		app-misc/mc
		net-irc/irssi
		net-misc/netkit-fingerd
		sys-apps/usbguard
	)"

#pentoo-full, X?
#			amd64? ( media-fonts/noto-emoji )
