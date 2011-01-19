# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-proxy/burpproxy/burpproxy-1.3_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

inherit versionator

MY_PV=$(delete_all_version_separators)

MY_P="${PN}${MY_PV}"

DESCRIPTION="A graphical cyber attack management tool for Metasploit"
HOMEPAGE="http://www.fastandeasyhacking.com/"
SRC_URI="http://www.fastandeasyhacking.com/download/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre
	net-analyzer/metasploit"

S=${WORKDIR}/${PN}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	mkdir -p "${D}"/opt/${PN}
	cp -a ${PN}.jar "${D}"/opt/${PN}
	cp -a ${PN}-logo.png "${D}"/opt/${PN}
	dodoc *.txt
	echo -e "#!/bin/sh \njava -jar -Xmx256m /opt/${PN}/${PN}.jar\n" > "${PN}"
	dobin ${PN}
}
