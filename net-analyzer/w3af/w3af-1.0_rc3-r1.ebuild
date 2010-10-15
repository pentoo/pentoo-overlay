# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="2"

inherit multilib python

DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk doc"

DEPEND="virtual/python"

RDEPEND=">=dev-python/fpconst-0.7.2
	dev-python/pygoogle-ajax
	dev-python/nltk
	dev-python/soappy
	dev-python/pyPdf
	dev-python/beautifulsoup
	dev-python/pyopenssl
	dev-python/json-py
	net-analyzer/scapy

	dev-python/utidylib

	gtk? ( dev-python/pysqlite
	dev-python/pygtk
	>=x11-libs/gtk+-2.12
	dev-python/pygraphviz )"

S="${WORKDIR}/${PN}"

src_prepare(){
	rm -r extlib/{BeautifulSoup.py,fpconst-0.7.2,jsonpy,nltk,nltk_contrib,pygoogle,pyPdf,scapy,SOAPpy,yaml} || die
	rm readme/{GPL,INSTALL} || die
}

src_install() {
	insinto /usr/$(get_libdir)/w3af
	doins -r core extlib locales plugins profiles scripts tools w3af_console || die
	fperms +x /usr/$(get_libdir)/w3af/w3af_console || die
	dobin "${FILESDIR}"/w3af_console
	if use gtk; then
		doins w3af_gui || die
		fperms +x /usr/$(get_libdir)/w3af/w3af_gui || die
		dobin "${FILESDIR}"/w3af_gui
	fi
	#use flag doc is here because doc is bigger than 3 Mb
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins -r readme/* || die
	fi
}
