# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Inguma is an open source penetration testing toolkit written completely in Python"
HOMEPAGE="http://inguma.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth gtk oracle"
SLOT="0"
RDEPEND="dev-python/Impacket
	 dev-python/paramiko
	 dev-python/pycrypto
	 dev-python/pysnmp
	 net-analyzer/nmap
	 net-analyzer/scapy
	 bluetooth? ( dev-python/pybluez )
	 gtk? ( dev-python/pygtk )
	 oracle? ( dev-python/cxoracle )"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	if ! use gtk; then
		rm ginguma.py
	else
		dosbin ${FILESDIR}/ginguma
	fi
	dodir /usr/lib/${PN}
	dodoc doc/*
	rm -rf doc
	rm -rf scapy* debian*
	cp -pPR ${S}/* ${D}usr/lib/${PN} || die
	chown -R root:0 ${D}
	dosbin ${FILESDIR}/inguma
}
