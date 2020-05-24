# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
IUSE_VIDEO_CARDS="video_cards_nvidia"
IUSE="amd-opencl intel-opencl opencl +dict ${IUSE_VIDEO_CARDS} livecd-stage1 pentoo-extra pentoo-full"
KEYWORDS="~amd64 ~arm ~x86"

#rocm is opencl for amd
#intel-neo is opencl for newer intel

PDEPEND="
	app-crypt/johntheripper-jumbo
	net-analyzer/hydra
	net-analyzer/medusa
	!arm? ( app-crypt/chntpw )
	!arm? ( !livecd-stage1? ( opencl? ( app-crypt/hashcat
		amd-opencl? ( dev-libs/rocm-opencl-runtime )
		intel-opencl? ( dev-libs/intel-neo )
		dev-libs/opencl-icd-loader
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
#	net-analyzer/authforce
#	app-crypt/md5bf

#stupid build system, doesn't work on hardened
#		app-crypt/hashkill

#bad cert
#		net-analyzer/thc-pptp-bruter

#not in the tree anymore?
#		net-analyzer/ncrack
