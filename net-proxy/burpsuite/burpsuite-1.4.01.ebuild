# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-proxy/burpproxy/burpproxy-1.3_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI=3

MY_P="${PN}_v${PV}"

DESCRIPTION="an interactive HTTP/S proxy server for attacking and debugging web-enabled applications"
HOMEPAGE="http://portswigger.net/suite/"
SRC_URI="http://portswigger.net/burp/${MY_P}.zip"

LICENSE="BURP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre"

S=${WORKDIR}/${MY_P}

src_install() {
	mkdir -p "${D}"/opt/${PN}
	cp -a ${MY_P}.jar "${D}"/opt/${PN}
	dodoc *.txt
	echo -e "#!/bin/sh \njava -jar -Xmx256m /opt/${PN}/${MY_P}.jar >/dev/null 2>&1 &\n" > "${PN}"
	dobin ${PN}
}
