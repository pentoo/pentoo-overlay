# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="You really need a description for intel-wimaxtools?"
HOMEPAGE="http://www.linuxwimax.org"
SRC_URI="http://kernel.org/pub/linux/kernel/people/inaky/wimax-tools-${PV}.tar.bz2"

inherit "eutils"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}/wimax-tools-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README || die
}

