# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

KEYWORDS="x86 amd64"
DESCRIPTION="Pentoo mobile meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	gnome-extra/cinnamon
	>=gnome-base/nautilus-3.4.2
	>=x11-themes/zukitwo-2012.07.02
	>=x11-terms/gnome-terminal-3.4.0
	>=media-gfx/gnome-screenshot-3.4.1
	>=gnome-extra/gnome-system-monitor-3.4.0
	>=gnome-extra/gnome-screensaver-3.4.4
	>=gnome-extra/gcalctool-3.4.0
	>=media-gfx/eog-3.4.0
	>=app-text/evince-3.4.0
	"
#>=gnome-base/gdm-3.4.1
