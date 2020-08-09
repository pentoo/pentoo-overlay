# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo cinnamon meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="gdm"
KEYWORDS="~amd64 ~x86"

PDEPEND="
	gnome-extra/cinnamon
	gnome-extra/nemo
	>=x11-themes/zukitwo-2012.07.02
	>=x11-terms/gnome-terminal-3.4.0
	>=media-gfx/gnome-screenshot-3.4.1
	>=gnome-extra/gnome-system-monitor-3.4.0
	>=gnome-extra/cinnamon-screensaver-4.4.1
	gnome-extra/gnome-calculator
	>=media-gfx/eog-3.4.0
	>=app-text/evince-3.4.0
	gdm? ( gnome-base/gdm )"
