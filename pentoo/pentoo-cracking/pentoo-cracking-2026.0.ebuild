# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="https://www.pentoo.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="opencl +dict livecd-stage1 pentoo-extra pentoo-full"

PDEPEND="
	app-crypt/johntheripper-jumbo
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
	# Fails to build on gcc 15, readd when fixed
	#net-analyzer/hydra
