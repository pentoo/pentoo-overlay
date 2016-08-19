# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3 toolchain-funcs

DESCRIPTION="rx_fm, rx_power, and rx_sdr tools for receiving data from SDRs"
HOMEPAGE="https://github.com/rxseger/rx_tools"

EGIT_REPO_URI="https://github.com/rxseger/rx_tools.git"
EGIT_CLONE_TYPE="shallow"
EGIT_CHECKOUT_DIR=${WORKDIR}/${P}


SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="net-wireless/soapysdr"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i \
		-e '/$(CC)/s!$(CFLAGS)!$(LDFLAGS) $(CFLAGS)!g' \
		-e "/^GITVER :=/s!= .(.*!=!g" \
		-e '/$(CC)/s!-DGIT=\"$(GITVER)\"!!g' \
		-e '/^CFLAGS =/{s,=,+=,;s,-g -ggdb,,;s,-O3,,;}' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake install DESTDIR="${D}" PREFIX=/usr

}
