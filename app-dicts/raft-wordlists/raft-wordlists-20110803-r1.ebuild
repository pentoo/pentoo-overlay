# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit unpacker

DESCRIPTION="Raft wordlists"
HOMEPAGE="http://code.google.com/p/raft/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/raft/${P}.7z"

S="${WORKDIR}/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86"

DEPEND="app-arch/p7zip"

src_unpack() {
	unpack_7z "${A}"
}

src_install() {
	insinto /usr/share/dict/raft-wordlists
	doins *.txt
}
