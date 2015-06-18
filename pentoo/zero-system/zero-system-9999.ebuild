# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="nu"

PDEPEND="
		app-eselect/eselect-sh
		app-arch/pixz
		app-shells/zsh
		app-shells/gentoo-zsh-completions
		app-shells/dash
		app-shells/mksh
		dev-vcs/mercurial
		app-arch/p7zip
		net-dns/dnsmasq
		app-portage/gentoolkit-dev
		app-portage/overlint
		app-misc/fslint
		app-doc/pms
		dev-vcs/cvs
		net-misc/keychain
		app-portage/pfl
		app-portage/genlop
		dev-util/checkbashisms
		sys-devel/distcc
		nu? ( dev-util/catalyst
			net-p2p/mktorrent
		)
		!nu? ( !arm? ( net-print/samsung-unified-linux-driver )
			mail-client/thunderbird
			!arm? ( mail-client/thunderbird-bin )
			media-sound/picard
			www-client/firefox
			!arm? ( www-client/firefox-bin )
			net-ftp/filezilla
			!arm? ( www-plugins/chrome-binary-plugins:stable )
			www-client/chromium
			!arm? ( www-client/google-chrome )
			app-office/libreoffice
			!arm? ( app-emulation/virtualbox[extensions] )
			!arm? ( sys-apps/preload )
			x11-misc/slim
			!arm? ( www-plugins/google-talkplugin )
			net-p2p/vuze
			!arm? ( app-emulation/wine )
			media-gfx/gimp
			x11-apps/mesa-progs
			media-video/xine-ui
			media-video/mplayer
			net-wireless/hidclient
			!arm? ( www-plugins/adobe-flash )
			x11-misc/redshift
			!arm? ( media-sound/baudline )
			app-portage/eclass-manpages
			dev-util/meld
		)
"
