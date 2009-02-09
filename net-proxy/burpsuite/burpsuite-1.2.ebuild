# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-proxy/burpproxy/burpproxy-1.3_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

MY_P="${PN}_v${PV}"
DESCRIPTION="Burp proxy is an interactive HTTP/S proxy server for attacking and debugging web-enabled applications"
HOMEPAGE="http://portswigger.net/suite/download.html"
SRC_URI="http://portswigger.net/suite/${MY_P}.zip"
LICENSE="PROPRIETARY"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/jre"

S=${WORKDIR}/${MY_P}
src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	mkdir -p ${D}/opt/${PN}
	cp -a ${MY_P}.jar ${D}/opt/${PN}
	dodoc *.txt *.java *.html
	echo -e "#!/bin/sh \njava -jar -Xmx256m /opt/${PN}/${MY_P}.jar\n" > ${PN}
	dosbin ${PN}
}
