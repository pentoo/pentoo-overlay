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

RDEPEND="${DEPEND}
	x86? ( app-fuzz/Peach )
	app-fuzz/bed
	app-fuzz/bss
	app-fuzz/fuzzer-server
	app-fuzz/http-fuzz
	app-fuzz/ohrwurm
	app-fuzz/smtp-fuzz
	x86? ( app-fuzz/smudge )
	net-analyzer/wfuzz
	app-fuzz/fuzzdb"
