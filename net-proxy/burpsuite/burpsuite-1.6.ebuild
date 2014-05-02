# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P="burpsuite_free_v${PV}.jar"

DESCRIPTION="an interactive HTTP/S proxy server for attacking and debugging web-enabled applications"
HOMEPAGE="http://portswigger.net/suite/"
SRC_URI="http://portswigger.net/burp/${MY_P}"

LICENSE="BURP"
SLOT="0"
KEYWORDS="amd64 x86"
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
