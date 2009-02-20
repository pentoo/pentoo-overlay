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
	dodir /usr/lib/${PN}
	for file in `grep -r -l -e " bin/" *`
	do
		sed -e 's: bin/: /usr/lib/fasttrack/bin/:g' -i "${file}"
	done
	for file in `grep -r -l -e "definepath=" *`
	do
		sed -e '/definepath=/ s:os.*:\"/usr/lib/fasttrack\":g' -i "${file}"
	done
	for file in `grep -r -l -e "\"bin/" *`
	do
		sed -e 's:\"bin/:\"/usr/lib/fasttrack/bin/:' -i "${file}"
	done
	sed -e '/launchgui/ s:python ::' -i ftgui
	# Setup msf path
	echo "/usr/lib/metasploit3/" > ${D}/bin/setup/metasploitconfig.file
	dosbin fast-track.py
	dosbin ftgui
	cp -pR bin ${D}/usr/lib/${PN}/
	dodoc readme/*
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

