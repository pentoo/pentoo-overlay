# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib

DESCRIPTION="Cyber Attack Management for Metasploit"
HOMEPAGE="http://www.fastandeasyhacking.com/"
SRC_URI="http://www.fastandeasyhacking.com/download/${PN}${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

PDEPEND="net-analyzer/metasploit
	net-analyzer/nmap
	virtual/jre"

S="${WORKDIR}/${PN}"

src_prepare() {

	# use armitage dir for the .store file
	sed -i -e "s:rm -f:mkdir ~/.${PN}; rm -f:" teamserver
	sed -i -e "s:./armitage.store:~/.${PN}/${PN}.store:" teamserver
	sed -i -e "s:armitage.jar:/usr/$(get_libdir)/${PN}/${PN}.jar:" teamserver

	sed -i -e "s:armitage.jar:/usr/$(get_libdir)/${PN}/${PN}.jar:" armitage
}

src_install() {
	dobin ${PN}
	dosbin teamserver
	doicon ${PN}-logo.png
	insinto /usr/$(get_libdir)/${PN}/
	doins ${PN}.jar cortana.jar
	dodoc readme.txt
}
