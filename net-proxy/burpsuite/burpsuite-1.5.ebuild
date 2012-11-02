# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-proxy/burpproxy/burpproxy-1.3_beta.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

EAPI=4

MY_P="burpsuite_free_v${PV}.jar"

DESCRIPTION="an interactive HTTP/S proxy server for attacking and debugging web-enabled applications"
HOMEPAGE="http://portswigger.net/suite/"
SRC_URI="http://portswigger.net/burp/${MY_P}"

LICENSE="BURP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre"

S=${WORKDIR}

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins ${DISTDIR}/${MY_P}
	echo -e "#!/bin/sh\njava -jar /opt/${PN}/${MY_P} >/dev/null 2>&1 &\n" > "${PN}"
	dobin ${PN}
}
