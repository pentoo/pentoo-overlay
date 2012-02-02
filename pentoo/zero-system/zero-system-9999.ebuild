# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="mail-client/thunderbird
		www-client/firefox
		www-client/chromium
		app-office/libreoffice
		app-admin/eselect-sh
		app-shells/zsh
		app-shells/dash
		app-emulation/virtualbox-bin
		gnome-extra/gnome-media
		dev-vcs/mercurial"
DEPEND="${RDEPEND}"
