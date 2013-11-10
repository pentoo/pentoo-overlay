# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo fuzzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	x86? ( app-fuzz/Peach )
	app-fuzz/bed
	app-fuzz/fuzzer-server
	app-fuzz/http-fuzz
	app-fuzz/ohrwurm
	app-fuzz/slowhttptest
	app-fuzz/smtp-fuzz
	x86? ( app-fuzz/smudge )
	net-analyzer/wfuzz
	app-fuzz/fuzzdb"
