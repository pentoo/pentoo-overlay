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
		net-ftp/filezilla
		www-client/chromium
		app-office/libreoffice
		app-admin/eselect-sh
		app-shells/zsh
		app-shells/dash
		app-shells/mksh
		app-emulation/virtualbox[extensions]
		gnome-extra/gnome-media
		dev-vcs/mercurial
		dev-python/pyserial
		app-arch/p7zip
		net-dns/dnsmasq
		x11-apps/mesa-progs
		sys-apps/preload
		app-portage/gentoolkit-dev
		media-sound/picard
		net-print/samsung-unified-linux-driver
		x11-misc/slim
		app-portage/overlint
		app-misc/fslint
		dev-util/catalyst
		app-doc/pms
		www-plugins/google-talkplugin
		net-p2p/vuze
		app-emulation/wine"
DEPEND="${RDEPEND}"
