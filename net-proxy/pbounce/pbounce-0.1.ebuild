# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Multiplexes multiple TCP connections into internal network via reverse connection"
HOMEPAGE="http://www.o0o.nu/projects/bouncers"
SRC_URI="http://www.o0o.nu/projects/bouncers/${P}.tar.gz?attredirects=0&d=1 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"

src_prepare() {
	#QA: LDFLAGS fix
	sed -i "s|^LDFLAGS=|#LDFLAGS=|g" Makefile
	default
}

src_install() {
	dobin pbounce
	dodoc README ChangeLog
}
