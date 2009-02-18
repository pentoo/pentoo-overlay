# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python distutils subversion
DESCRIPTION="Let's pop a box"
HOMEPAGE="http://thepentest.com"
ESVN_REPO_URI="http://svn.thepentest.com/fasttrack/"

LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"
EAPI=2

RDEPEND="net-analyzer/nmap
	net-analyzer/ettercap  
	net-analyzer/metasploit[sqlite3]
	net-ftp/proftpd
	dev-db/freetds
	dev-python/pymssql
	dev-python/pymills
	dev-python/pexpect
	dev-python/clientform
	dev-python/beautifulsoup
	!slow? ( dev-python/psyco )"

src_compile() {
	true;
}

src_install() {
	echo 'THIS DOESN"T ACTUALLY WORK YET' && die
	dodir /usr/lib/${PN}
	mv ${S}/fast-track.py ${S}/fast-track.py.bak
	sed 's! bin/! /usr/lib/fasttrack/bin/!' ${S}/fast-track.py.bak > ${S}/fast-track.py.1
	sed 's!"bin/!"/usr/lib/fasttrack/bin/!' ${S}/fast-track.py.1 > ${S}/fast-track.py
	dosbin ${S}/fast-track.py
	mv ${S}/ftgui ${S}/ftgui.bak
	sed 's! bin/!/usr/lib/fasttrack/bin/!' ${S}/ftgui.bak > ${S}/ftgui.1
	sed 's!fast-track.py!/usr/sbin/fast-track.py!' ${S}/ftgui.1 > ${S}/ftgui
	dosbin ${S}/ftgui
	dodir /usr/lib/${PN}/bin
	cp -pR ${S}/bin /usr/lib/${PN}/bin
	dodoc readme/*
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

