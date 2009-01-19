# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/wifitap/wifitap-0.3.7.ebuild,v 1.1.1.1 2006/03/29 19:41:59 grimmlin Exp $

inherit python

DESCRIPTION="A wireless tool to do direct connection to client without passing through an AP"
HOMEPAGE="http://sid.rstack.org/index.php/Wifitap_EN"
SRC_URI="http://sid.rstack.org/code/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="speed"

DEPEND="virtual/python
	speed? ( dev-python/psyco )
	>=app-fuzz/scapy-1.0.3"

S=${WORKDIR}/${PN}

src_install() {
	exeinto /usr/bin
	newexe wifitap.py wifitap
	newexe wifidns.py wifidns
	newexe wifiping.py wifiping

	# also install scapy as a importable python module
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	rm scapy.py
	doins *.py

	dodoc AUTHORS README Changelog BUGS TODO
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

