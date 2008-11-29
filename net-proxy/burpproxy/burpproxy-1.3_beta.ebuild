# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-proxy/burpproxy/burpproxy-1.3_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

MY_P="${PN}_v1.3beta"
DESCRIPTION="Burp proxy is an interactive HTTP/S proxy server for attacking and debugging web-enabled applications"
HOMEPAGE="http://portswigger.net/proxy/download.html"
SRC_URI="http://portswigger.net/proxy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=virtual/jre-1.4*"

S=${WORKDIR}/${MY_P}
src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	mkdir -p ${D}/opt/${PN}
	cp -a ${MY_P}.jar ${D}/opt/${PN}
	dodoc *.txt
	echo -e "#!/bin/sh \njava -jar -Xmx256m /opt/burpproxy/${MY_P}.jar\n" > burpproxy
	dosbin burpproxy
}
