# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT="python2_7"
inherit python-single-r1 multilib

DESCRIPTION="Inguma is an open source penetration testing toolkit written completely in Python"
HOMEPAGE="http://inguma.eu/projects/inguma"
SRC_URI="http://inguma.eu/attachments/download/105/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth gtk oracle"
SLOT="0"
RDEPEND="dev-python/impacket
	 dev-python/paramiko
	 dev-python/pycrypto
	 dev-python/pygtksourceview
	 dev-python/pysnmp
	 net-analyzer/nmap
	 net-analyzer/scapy
	 bluetooth? ( dev-python/pybluez )
	 gtk? ( dev-python/pygtk )
	 oracle? ( dev-python/cxoracle )"

QA_PREBUILT="usr/$(get_libdir)/${PN}/lib/pyshellcodelib/x86/test"

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	dodoc doc/*
	rm -rf doc
	rm -rf scapy* debian*

	cp -pPR ${S}/* "${ED}"/usr/$(get_libdir)/${PN} || die
	dodir /usr/sbin
	cat <<-EOF > "${ED}"/usr/sbin/${PN}
		#!/bin/sh
		cd /usr/$(get_libdir)/${PN}
		exec ./${PN}.py "\$@"
	EOF
	fperms +x /usr/sbin/${PN} /usr/$(get_libdir)/${PN}/${PN}.py
	if ! use gtk; then
		rm ginguma.py
	else
		cat <<-EOF > "${ED}"/usr/sbin/g${PN}
			#!/bin/sh
			cd /usr/$(get_libdir)/${PN}
			exec ./g${PN}.py "\$@"
		EOF
		fperms +x /usr/sbin/ginguma /usr/$(get_libdir)/${PN}/ginguma.py
	fi
	fowners -R root:0 /
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}
}
