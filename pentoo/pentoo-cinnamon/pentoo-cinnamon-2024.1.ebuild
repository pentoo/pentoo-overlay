# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo cinnamon meta ebuild"
HOMEPAGE="https://www.pentoo.org"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gdm"

PDEPEND="
	gnome-extra/cinnamon
	gnome-extra/nemo
	>=x11-terms/gnome-terminal-3.4.0
	>=media-gfx/gnome-screenshot-3.4.1
	>=gnome-extra/gnome-system-monitor-3.4.0
	>=gnome-extra/cinnamon-screensaver-4.4.1
	gnome-extra/gnome-calculator
	>=media-gfx/eog-3.4.0
	>=app-text/evince-3.4.0
	gdm? ( gnome-base/gdm )"
