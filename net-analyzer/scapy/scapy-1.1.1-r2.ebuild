# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scapy/scapy-1.1.1-r1.ebuild,v 1.8 2011/04/05 17:28:33 arfrever Exp $

EAPI="3"

inherit eutils python multilib

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="http://www.secdev.org/projects/scapy/"
SRC_URI="http://www.secdev.org/projects/scapy/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnuplot pyx crypt graphviz imagemagick visual tcpreplay"

DEPEND="dev-lang/python"
RDEPEND="net-analyzer/tcpdump
	gnuplot? ( dev-python/gnuplot-py )
	pyx? ( dev-python/pyx )
	crypt? ( dev-python/pycrypto )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( || ( media-gfx/imagemagick
						media-gfx/graphicsmagick[imagemagick] ) )
	visual? ( dev-python/visual )
	tcpreplay? ( net-analyzer/tcpreplay )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-config-file.patch
	epatch "${FILESDIR}"/${P}-with-which-width.patch
}

src_install() {
	exeinto /usr/bin
	newexe scapy.py scapy

	# also install scapy as a importable python module
	insinto $(python_get_sitedir)
	doins scapy.py

	insinto /etc
	doins "${FILESDIR}"/ethertypes
	dodoc AUTHORS README changelog.txt
	doman scapy.1
}

pkg_postinst() {
	python_mod_optimize scapy.py

	einfo ""
	einfo "- Check http://www.secdev.org/projects/scapy/ for additional info"
	einfo ""
	einfo "- To subscribe to the mailing-list, send a mail to scapy.ml-subscribe(at)secdev.org"
	einfo "- To send a mail to the mailing-list: scapy.ml(at)secdev.org"
	einfo "- Web archive : http://news.gmane.org/gmane.comp.security.scapy.general"
	einfo "- NNTP, RSS, etc : http://gmane.org/info.php?group=gmane.comp.security.scapy.general"
	einfo ""
}

pkg_postrm() {
	python_mod_cleanup scapy.py
}
