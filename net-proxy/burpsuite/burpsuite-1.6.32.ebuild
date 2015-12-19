# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="burpsuite_free_v${PV}.jar"

DESCRIPTION="an interactive HTTP/S proxy server for attacking and debugging web-enabled applications"
HOMEPAGE="https://portswigger.net/burp/"
SRC_URI="http://portswigger.net/burp/${MY_P}"

LICENSE="BURP"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="fetch"

DEPEND=""
RDEPEND="virtual/jre"

S=${WORKDIR}

pkg_nofetch() {
		einfo "Please download ${A} from ${HOMEPAGE}/downloadfree.html"
		einfo "The archive should then be placed into ${DISTDIR}."
}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	dodir /opt/"${PN}"
	insinto /opt/"${PN}"
	doins "${DISTDIR}/${MY_P}"
	echo -e "#!/bin/sh\njava -jar /opt/${PN}/${MY_P} >/dev/null 2>&1 &\n" > "${PN}"
	dobin ${PN}
}
