# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2 autotools

DESCRIPTION="An advanced CPU-based password recovery utility"
HOMEPAGE="https://github.com/hashcat/hashcat"
EGIT_REPO_URI="https://github.com/hashcat/hashcat.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_prepare() {
	#quick hack to compile on supported platforms only
	use amd64 && sed -e "s|all: binaries|all: posix64|g" -i src/Makefile
	use x86  && sed -e "s|all: binaries|all: posix32|g" -i src/Makefile
	#do not strip
	sed -e "s|-s -fomit-frame-pointer|-fomit-frame-pointer|g" -i src/Makefile
}

src_install() {
	dobin hashcat-cli64.bin
}
