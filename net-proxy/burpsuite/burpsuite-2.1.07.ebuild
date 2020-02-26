# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="burpsuite_community_v${PV}.jar"

DESCRIPTION="Interactive proxy for attacking and debugging web applications"
HOMEPAGE="https://portswigger.net/burp/"
SRC_URI="https://portswigger.net/burp/releases/download?product=community&version=${PV} -> ${MY_P}"

LICENSE="BURP"
SLOT="0"
KEYWORDS="amd64 x86"
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

#	echo -e "#!/bin/sh\njava -Xmx2G -jar /opt/${PN}/${MY_P} >/dev/null 2>&1 &\n" > "${PN}"
#	dobin ${PN}

	newbin - ${PN} <<-EOF
		#!/bin/sh
		java -Xmx2G -jar /opt/${PN}/${MY_P} >/dev/null 2>&1 &
	EOF
}
