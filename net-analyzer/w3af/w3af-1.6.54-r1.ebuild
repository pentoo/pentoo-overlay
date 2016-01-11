# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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
IUSE="clamav doc gtk test"

#<@__apr__> Zero_Chaos, unittests are just for developers to run
#<@__apr__> Zero_Chaos, users should never run "nosetests" in w3af
RESTRICT=test

#dev-python/pyClamd
#net-proxy/mitmproxy

RDEPEND=">=dev-python/fpconst-0.7.2
	>=app-text/pdfminer-20140328
	>=dev-python/chardet-2.1.1
	clamav? ( dev-python/clamd )
	>=dev-python/esmre-0.3.1
	>=dev-python/git-python-1.0.1
	dev-python/guess-language
	dev-python/halberd
	>=dev-python/msgpack-0.4.4
	=dev-python/nltk-2.0.4
	dev-python/phply
	dev-python/pyopenssl
	dev-python/pysvn
	dev-python/python-cluster
	dev-python/python-ntlm
	>=dev-python/PyGithub-1.21.0
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
	>=dev-python/futures-2.1.5
	>=dev-python/tblib-0.2.0
	>=dev-python/ruamel-ordereddict-0.4.8
	>=dev-python/vulndb-0.0.17
	gtk? ( dev-python/pygraphviz
		>dev-python/pygtk-2.0
		=dev-python/xdot-0.6
		dev-python/pygtksourceview )
	dev-python/DartsPyLRU"
DEPEND=""

src_prepare(){
	rm doc/{GPL,INSTALL} || die
	find "${S}" -type d -name .svn -exec rm -R {} +
	#bundled sqlmap
	rm -r w3af/plugins/attack/db/sqlmap || die
	use clamav || rm w3af/plugins/grep/clamav.py
	#Halberd hmap is also bundled
	epatch "${FILESDIR}"/${P}_disable_deps_check.patch
}

src_install() {
	insinto /usr/$(get_libdir)/w3af
	doins -r w3af profiles scripts tools w3af_console
	if use gtk ; then
		doins w3af_gui
		fperms +x /usr/$(get_libdir)/w3af/w3af_gui || die
	fi
	fperms +x /usr/$(get_libdir)/w3af/w3af_console || die
	dobin "${FILESDIR}"/w3af_console || die
	if use gtk ; then
		dobin "${FILESDIR}"/w3af_gui || die
	fi
	#use flag doc is here because doc is bigger than 3 Mb
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/* || die
	fi
}
