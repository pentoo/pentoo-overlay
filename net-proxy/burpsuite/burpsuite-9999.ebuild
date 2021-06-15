# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="Interactive proxy for attacking and debugging web applications"
HOMEPAGE="https://portswigger.net/burp/"

#https://portswigger.net/burp/releases
MY_PV=${PV/_pre/}
if [[ "${PN}" == *"pro" ]]; then
	MY_P="burpsuite_pro_v${MY_PV}.jar"
	SRC_URI="https://portswigger.net/burp/releases/download?product=pro&version=${MY_PV}&type=Jar  -> ${MY_P}"
else
	MY_P="burpsuite_community_v${MY_PV}.jar"
	SRC_URI="https://portswigger.net/burp/releases/download?product=community&version=${MY_PV} -> ${MY_P}"
fi

if [[ "${PV}" == *9999 ]]; then
	SRC_URI=""
	KEYWORDS=""
#	eerror "9999 is a template, do not use it"
elif [[ "${PV}" == *"pre" ]]; then
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS="amd64 x86"
fi

LICENSE="BURP"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="|| ( virtual/jre virtual/jdk )"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	dodir /opt/"${PN}"
	insinto /opt/"${PN}"
	doins "${MY_P}"

	newbin - ${PN} <<-EOF
		#!/bin/sh
		export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
		java -Xmx2G -jar /opt/${PN}/${MY_P} >/dev/null 2>&1 &
	EOF

if [[ "${PN}" == *"pro" ]]; then
	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png
fi

}
