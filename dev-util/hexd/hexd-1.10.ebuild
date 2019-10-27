# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

#old: sys-apps/hexdump-esr

DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexd/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

# tests are broken in this release(missing files)
#RESTRICT="test"

src_prepare() {
	sed -i Makefile \
		-e "s|-O |${CFLAGS} ${LDFLAGS} |g" \
		|| die "sed on Makefile failed"
	tc-export CC
	eapply_user
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc NEWS README
}
