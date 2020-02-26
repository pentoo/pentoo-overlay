# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="cuda opencl +dict ${IUSE_VIDEO_CARDS} livecd-stage1 pentoo-extra pentoo-full"
KEYWORDS="~amd64 ~arm ~x86"

PDEPEND="
	app-crypt/johntheripper-jumbo
	net-analyzer/hydra
	net-analyzer/medusa
	!arm? ( app-crypt/chntpw )
	!arm? ( !livecd-stage1? ( opencl? ( app-crypt/hashcat
		dev-libs/ocl-icd[khronos-headers(-)]
		net-wireless/hcxkeys ) ) )

	pentoo-extra? (
		app-crypt/ophcrack
		app-dicts/seclists
	)
	pentoo-full? (
		dict? ( app-dicts/raft-wordlists
			app-misc/crunch )
		app-text/cewl
		app-crypt/SIPcrack
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
