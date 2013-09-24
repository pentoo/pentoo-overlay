# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 arm x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="+accessibility gtk java qt4 X"

DEPEND=""
RDEPEND="${DEPEND}
	accessibility? ( app-accessibility/espeakup
			app-accessibility/brltty )
	gtk? ( media-video/gtk-recordmydesktop )
	qt4? ( !gtk? ( media-video/qt-recordmydesktop ) )
	X? ( app-editors/gedit
	app-editors/ghex
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
	net-dialup/linux-atm
	net-dialup/minicom
	net-dialup/wvdial
	net-dns/bind-tools
	net-firewall/sanewall
	net-fs/nfs-utils
	net-ftp/ftp
	net-ftp/oftpd
	net-ftp/tftp-hpa
	net-irc/irssi
	net-misc/axel
	net-misc/curl
	net-misc/ifenslave
	net-misc/iperf
	net-misc/iputils
	net-misc/netkit-fingerd
	net-misc/netkit-rsh
	net-misc/netsed
	net-misc/ntp
	net-misc/openssh
	net-misc/openvpn
	net-misc/stunnel
	net-misc/tcpick
	net-misc/telnet-bsd
	net-misc/vpnc
	net-misc/whatmask
	net-misc/whois
	net-misc/wlan2eth
	sys-apps/ethtool
	sys-apps/iproute2
	!arm? ( sys-boot/unetbootin )
	sys-power/powertop
	www-client/links
	www-client/lynx
	www-servers/lighttpd
"
