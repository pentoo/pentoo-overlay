# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2 eutils

DESCRIPTION="Utility for network exploration with Samba support."
HOMEPAGE="http://autoscan-network.com/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="snmp samba nessus trayicon gtk gnome vnc +console sound"
SRC_URI="http://autoscan-network.com/download_files/${P}.tar.gz"

RDEPEND="net-analyzer/nmap
	gnome? ( >=gnome-base/libgnomeui-2.0
		 >=gnome-base/gnome-keyring-0.4.2 )
	samba? ( net-fs/samba )
	gtk? (  >=x11-libs/gtk+-2.6.0
		>=gnome-extra/gtkhtml-2.0
		>=gnome-base/gnome-vfs-2.8.4
		>=x11-libs/pango-1.8.1 )
	vnc? ( >=net-libs/gtk-vnc-0.2.0 )
	console? ( >=x11-libs/vte-0.11.12 )
	sound? ( >=media-libs/libao-0.8.5
		 >=media-libs/libvorbis-1.1.0 )
	nessus? ( net-analyzer/nessus )
	snmp? ( >=net-analyzer/net-snmp-5.0 )
	>=dev-libs/glib-2.6.3
	dev-libs/libelf"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i 's| curl| libcurl|g' configure || die
}

src_configure() {
	if use samba; then
		sed -i -e '/MODULE_SAMBA=/ s/disable/enable/g' configure
	fi
	if ! use sound; then
		sed -i -e '/SOUND=/ s/enable/disable/g' configure
	fi
	if ! use gnome; then
		sed -i -e '/GNOME=/ s/enable/disable/g' configure
	fi
	if ! use snmp; then
		sed -i -e '/SNMP=/ s/enable/disable/g' configure
	fi
	if use nessus; then
		sed -i -e '/MODULE_NESSUS=/ s/disable/enable/g' configure
	fi
	if use vnc; then
		sed -i -e '/VNC=/ s/disable/enable/' configure
	fi
	if ! use trayicon; then
		sed -i -e '/TRAYICON=/ s/enable/disable/g' configure
	fi
	if ! use console; then
		sed -i -e '/MODULE_CONSOLE=/ s/enable/disable/g' configure
	fi
	./configure --distrib-gentoo || die "Configure failed"
}

src_compile() {
	emake || die "emake failed"
}
