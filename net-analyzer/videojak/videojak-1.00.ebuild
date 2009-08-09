# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="VideoJak is an IP Video security assessment tool"
HOMEPAGE="http://videojak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

inherit eutils
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI=2

DEPEND="net-analyzer/ettercap"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	rm -f ${D}/usr/share/man/man8/ettercap_plugins.8.bz2 ${D}/usr/share/man/man8/ettercap.8.bz2
	rm -f ${D}/usr/share/man/man8/etterfilter.8.bz2 ${D}/usr/share/man/man8/ettercap_curses.8.bz2
	rm -f ${D}/usr/share/man/man8/etterlog.8.bz2 ${D}/usr/share/man/man5/etter.conf.5.bz2
 	rm -f ${D}/usr/bin/etterlog ${D}/usr/bin/etterfilter
}
