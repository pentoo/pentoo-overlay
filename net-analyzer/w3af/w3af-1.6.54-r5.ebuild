# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

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
IUSE="clamav doc test"

#<@__apr__> Zero_Chaos, unittests are just for developers to run
#<@__apr__> Zero_Chaos, users should never run "nosetests" in w3af
RESTRICT=test

RDEPEND="
	clamav? ( dev-python/clamd )
	>=dev-python/PyGithub-1.21.0
	>=dev-python/git-python-1.0.1
	>=dev-python/pybloomfiltermmap-0.3.14
	>=dev-python/esmre-0.3.1
	>=dev-python/phply-0.9.1
	dev-python/stopit
	>=dev-python/nltk-3.0.1
	>=dev-python/chardet-2.1.1
	>=dev-python/tblib-0.2.0
	>=app-text/pdfminer-20140328
	>=dev-python/futures-2.1.5
	>=dev-python/pyopenssl-0.13.1
	dev-python/ndg-httpsclient
	dev-python/pyasn1
	>=dev-python/lxml-3.4.4
	>=net-analyzer/scapy-2.0.0
	>=dev-python/guess-language-0.2
	dev-python/python-cluster
	>=dev-python/msgpack-0.4.4
	>=dev-python/python-ntlm-1.0.1
	>=dev-python/halberd-0.2.4
	>=dev-python/DartsPyLRU-0.5
	dev-python/jinja
	>=dev-python/vulndb-0.0.17
	dev-python/markdown
	>=dev-python/psutil-2.2.1
	>=dev-python/ruamel-ordereddict-0.4.8
	dev-python/soappy

	dev-db/sqlmap
	|| ( net-analyzer/openbsd-netcat
		net-analyzer/netcat )"

#pywebkitgtk is vulnerable and removed
#	gtk? ( dev-python/pywebkitgtk
#		dev-python/pygraphviz
#		>dev-python/pygtk-2.0
#		=dev-python/xdot-0.6
#		dev-python/pygtksourceview )

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
#	if use gtk ; then
#		doins w3af_gui
#		fperms +x /usr/$(get_libdir)/w3af/w3af_gui || die
#	fi
	fperms +x /usr/$(get_libdir)/w3af/w3af_console || die
	dobin "${FILESDIR}"/w3af_console || die
#	if use gtk ; then
#		dobin "${FILESDIR}"/w3af_gui || die
#	fi
	#use flag doc is here because doc is bigger than 3 Mb
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/* || die
	fi
}
