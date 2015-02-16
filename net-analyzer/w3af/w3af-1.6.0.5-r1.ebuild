# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv Exp $

EAPI=5

PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python2_7 )

inherit multilib python-r1

DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
SRC_URI="https://github.com/andresriancho/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk clamav"

RDEPEND=">=dev-python/fpconst-0.7.2
	=app-text/pdfminer-20110515
	dev-python/chardet
	clamav? ( dev-python/clamd )
	dev-python/esmre
	dev-python/git-python
	dev-python/esmre
	dev-python/guess-language
	dev-python/halberd
	dev-python/msgpack
	=dev-python/nltk-2.0.4
	dev-python/phply
	dev-python/pyopenssl
	dev-python/pysvn
	dev-python/python-cluster
	dev-python/python-ntlm
	=dev-python/PyGithub-1.21.0
	=dev-python/DartsPyLRU-0.5
	dev-python/pyyaml
	dev-python/simplejson
	dev-python/soappy
	|| (
		net-analyzer/gnu-netcat
		net-analyzer/netcat
		net-analyzer/netcat6 )
	>=net-analyzer/scapy-2
	dev-db/sqlmap
	dev-python/lxml
	dev-python/pybloomfiltermmap
	=dev-python/futures-2.1.5
	gtk? ( dev-python/pygraphviz
		>dev-python/pygtk-2.0
		=dev-python/xdot-0.6
		dev-python/pygtksourceview )"
DEPEND=""

src_prepare() {
	rm doc/{GPL,INSTALL} || die
	find "${S}" -type d -name .svn -exec rm -R {} +
	#bundled sqlmap
	rm -r w3af/plugins/attack/db/sqlmap || die
	use clamav || rm w3af/plugins/grep/clamav.py
	#Halberd hmap is also bundled
	epatch "${FILESDIR}"/${PN}-1.6.0.3_disable_deps_check.patch
}

src_install() {
	#use flag doc is here because doc is bigger than 3 Mb
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/*
	fi

	rm -r doc circle.yml

	dodir /usr/$(get_libdir)/w3af
	cp -R * "${ED}"/usr/$(get_libdir)/${PN}
	use gtk && dobin "${FILESDIR}"/w3af_gui
	dobin "${FILESDIR}"/w3af_console
}
