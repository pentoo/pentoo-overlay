# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo fuzzers meta ebuild"
HOMEPAGE="https://www.pentoo.org"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="pentoo-full"

PDEPEND="net-analyzer/wfuzz
	net-analyzer/gobuster
	pentoo-full? (
		app-fuzz/bed
		app-fuzz/fuzzdb
		app-fuzz/http-fuzz
		app-fuzz/slowhttptest
		app-fuzz/smtp-fuzz
	)"
