# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Raft wordlists"
HOMEPAGE="http://code.google.com/p/raft/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/raft/${P}.7z"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-arch/p7zip"

S="${WORKDIR}/"

src_install(){
    insinto /usr/share/dict/raft-wordlists
    doins *.txt
}
