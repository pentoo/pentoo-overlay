# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils python distutils subversion

DESCRIPTION="Let's pop a box"
HOMEPAGE="http://thepentest.com"
ESVN_REPO_URI="http://svn.thepentest.com/fasttrack/"

LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
IUSE="speed"
SLOT="0"

RDEPEND="net-analyzer/nmap
	net-analyzer/ettercap
	net-analyzer/metasploit[sqlite]
	net-ftp/proftpd
	dev-db/freetds
	dev-python/pymssql
	dev-python/pymills
	dev-python/pexpect
	dev-python/beautifulsoup
	speed? ( x86? ( dev-python/psyco ) )"

src_compile() {
	#speed/psyco should automatically be disabled on all arches besides x86, this should do it
	if use speed; then if use !x86; then einfo "Psyco (speed) support only available on x86"; fi; fi
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
	dodir /bin/setup
	echo "/usr/lib/metasploit3/" > "${D}"/bin/setup/metasploitconfig.file
	dosbin fast-track.py
	dosbin ftgui
	cp -pR bin "${D}"/usr/lib/${PN}/
	dodoc readme/*
}
