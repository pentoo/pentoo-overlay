# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL"
SLOT="0"
IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="cuda opencl dict ${IUSE_VIDEO_CARDS} livecd-stage1 minipentoo"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-crypt/johntheripper
	net-analyzer/hydra
	net-analyzer/medusa

	!minipentoo? (
		!arm? ( app-crypt/chntpw
		    app-crypt/hashcat-gui
		)
		!livecd-stage1? (
			video_cards_nvidia? (
				opencl? ( net-wireless/pyrit[opencl] )
				cuda? ( net-wireless/pyrit[cuda] )
			)
		)
		dict? ( app-dicts/raft-wordlists
			app-misc/crunch )
		app-crypt/ophcrack
		app-text/cewl
		app-crypt/SIPcrack
		net-misc/rdesktop-brute
	)"

#removed from stage1? because it doesn't build for me
#	app-crypt/cuda-rarcrypt
#	net-analyzer/authforce
#	app-crypt/md5bf

#stupid build system, doesn't work on hardened
#		app-crypt/hashkill

#bad cert
#		net-analyzer/thc-pptp-bruter

#not in the tree anymore?
#		net-analyzer/ncrack
