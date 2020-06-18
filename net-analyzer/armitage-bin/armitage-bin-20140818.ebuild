# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib

#Crazy name, issue https://code.google.com/p/armitage/issues/detail?id=165
MY_PV="140818"
MY_PN="armitage"

DESCRIPTION="Cyber Attack Management for Metasploit"
HOMEPAGE="http://www.fastandeasyhacking.com/"
SRC_URI="http://www.fastandeasyhacking.com/download/${MY_PN}${MY_PV}.tgz"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~arm ~x86"  # Requires metasploit, which is dropped

PDEPEND="net-analyzer/metasploit
	net-analyzer/nmap
	virtual/jre"
DEPEND="!net-analyzer/armitage"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	# use armitage dir for the .store file
	sed -i -e "s:rm -f:mkdir ~/.${MY_PN}; rm -f:" teamserver
	sed -i -e "s:./armitage.store:~/.${MY_PN}/${MY_PN}.store:" teamserver
	sed -i -e "s:armitage.jar:/usr/$(get_libdir)/${MY_PN}/${MY_PN}.jar:" teamserver

	sed -i -e "s:armitage.jar:/usr/$(get_libdir)/${MY_PN}/${MY_PN}.jar:" armitage
}

src_install() {
	dobin ${MY_PN}
	dosbin teamserver
	doicon ${MY_PN}-logo.png
	insinto /usr/$(get_libdir)/${MY_PN}/
	doins ${MY_PN}.jar cortana.jar
	dodoc readme.txt
}
