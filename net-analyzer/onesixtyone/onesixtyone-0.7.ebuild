# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="An efficient SNMP scanner"
HOMEPAGE="https://labs.portcullis.co.uk/application/onesixtyone/"
#Upstream seems dead
#SRC_URI="https://labs.portcullis.co.uk/download/${P}.tar.gz"
SRC_URI="https://pentoo.org/~zero/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_prepare() {
	eapply "${FILESDIR}/${P}-uninline-timeval_subtract.patch"
	# Comment out the unnecessary CC and CFLAGS variables from the Makefile
	sed -i -e "s|CC=gcc||g" -e "s|CFLAGS=-O2 -pipe||g" Makefile || die "sed failed"
	sed -i -e 's#$(CFLAGS)#$(CFLAGS) $(LDFLAGS)#g' Makefile || die "sed failed again"
	default
}

src_install() {
	dobin onesixtyone

	insinto "/usr/share/${PN}"
	doins dict.txt

	dodoc ChangeLog INSTALL README
}
