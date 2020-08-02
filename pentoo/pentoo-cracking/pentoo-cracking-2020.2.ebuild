# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
IUSE="opencl +dict livecd-stage1 pentoo-extra pentoo-full"
KEYWORDS="~amd64 ~arm ~x86"

PDEPEND="
	app-crypt/johntheripper-jumbo
	net-analyzer/hydra
	!arm? (
		app-crypt/chntpw
		!livecd-stage1? (
							opencl? (
									pentoo/pentoo-opencl
									app-crypt/hashcat
									net-wireless/hcxkeys
							)
		)
	)

	pentoo-full? (
	net-analyzer/medusa
		dict? ( app-dicts/raft-wordlists
			app-misc/crunch )
		app-text/cewl
		app-crypt/SIPcrack
	)

	pentoo-extra? (
		app-crypt/ophcrack
		app-dicts/seclists
	)"
