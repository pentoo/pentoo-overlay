# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo fuzzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="minipentoo"

DEPEND=""
RDEPEND="net-analyzer/wfuzz
	!minipentoo? (
		app-fuzz/bed
		app-fuzz/fuzzdb
		app-fuzz/fuzzer-server
		app-fuzz/http-fuzz
		app-fuzz/ohrwurm
		app-fuzz/slowhttptest
		app-fuzz/smtp-fuzz
	)"
