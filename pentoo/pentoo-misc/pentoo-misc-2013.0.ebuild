# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo misc meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="amd64 arm x86"
SLOT="0"
LICENSE="GPL-3"

DEPEND=""
RDEPEND="${DEPEND}
	app-admin/localepurge
	app-crypt/openvpn-blacklist
	app-editors/gedit
	app-editors/ghex
	app-editors/hexedit
	app-editors/nano
	app-editors/vim
	app-misc/dradis
	app-misc/mc
	app-misc/screen
	app-portage/layman
	app-portage/smart-live-rebuild
	app-text/dos2unix
	app-text/uudeview
	app-text/wgetpaste
	dev-libs/libxslt
	dev-vcs/subversion
	media-fonts/dejavu
	media-fonts/font-misc-misc
	media-gfx/fbgrab
	media-gfx/scrot
	media-sound/alsa-utils
	media-sound/alsamixergui
	media-sound/audacious
	media-sound/sox
	media-video/vlc
	net-dialup/linux-atm
	net-dialup/lrzsz
	net-dialup/minicom
	net-dialup/ppp
	net-dialup/wvdial
	net-dns/bind-tools
	net-firewall/sanewall
	net-firewall/iptables
	|| ( net-fs/mount-cifs net-fs/samba )
	net-fs/nfs-utils
	net-ftp/tftp-hpa
	net-ftp/ftp
	net-ftp/gproftpd
	net-ftp/oftpd
	net-im/pidgin
	net-im/jitsi-bin
	net-irc/irssi
	net-misc/axel
	net-misc/curl
	net-misc/dhcp
	net-misc/dhcpcd
	net-misc/grdesktop
	net-misc/ifenslave
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
	net-misc/vconfig
	net-misc/vpnc
	net-misc/whatmask
	net-misc/whois
	|| ( net-misc/wicd net-misc/networkmanager )
	net-misc/wlan2eth
	sys-apps/ethtool
	sys-apps/fbset
	sys-apps/iproute2
	sys-apps/sysvinit
	sys-block/gparted
	sys-devel/crossdev
	sys-devel/gettext
	sys-fs/jfsutils
	sys-fs/reiser4progs
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	www-client/links
	www-client/lynx
	www-servers/lighttpd"
