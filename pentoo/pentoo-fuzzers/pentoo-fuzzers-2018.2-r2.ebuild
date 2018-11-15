# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo fuzzers meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="pentoo-full"

PDEPEND="net-analyzer/wfuzz
	pentoo-full? (
		app-fuzz/bed
		app-fuzz/fuzzdb
		app-fuzz/fuzzer-server
		app-fuzz/http-fuzz
		app-fuzz/slowhttptest
		app-fuzz/smtp-fuzz
	)"
