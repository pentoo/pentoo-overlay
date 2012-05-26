# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd-stage1"

DEPEND=""

RDEPEND="${DEPEND}
	!livecd-stage1? ( app-crypt/pyrit
		app-crypt/hashcat-gui
		app-crypt/cryptohaze-combined )
	app-text/cewl
	app-crypt/SIPcrack
	app-crypt/chntpw
	app-crypt/johntheripper
	app-crypt/ophcrack
	net-analyzer/ncrack
	net-analyzer/medusa
	net-analyzer/thc-pptp-bruter
	net-misc/rdesktop-brute"
#removed from stage2? because it doesn't build for me
#	app-crypt/cuda-rarcrypt
#	net-analyzer/authforce
#	app-crypt/md5bf
