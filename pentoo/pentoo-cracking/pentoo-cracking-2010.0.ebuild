# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo fuzzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

#fuzzers
RDEPEND="${RDEPEND}
	app-text/cewl
	app-crypt/SIPcrack
	app-crypt/chntpw
	app-crypt/cuda-multiforcer
	app-crypt/cuda-rarcrypt
	app-crypt/johntheripper[mpi]
	app-crypt/md5bf
	app-crypt/pyrit
	app-crypt/ophcrack
	net-analyzer/authforce
	net-analyzer/thc-pptp-bruter
	net-misc/rdesktop-brute"
