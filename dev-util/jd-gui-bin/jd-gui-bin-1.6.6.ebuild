# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="jd-gui"
MY_P="${MY_PN}-${PV}"

inherit desktop

DESCRIPTION="A standalone Java Decompiler GUI"
HOMEPAGE="http://jd.benow.ca/"
SRC_URI="https://github.com/java-decompiler/jd-gui/releases/download/v${PV}/${MY_P}.jar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
	!dev-util/jd-gui"

S="${WORKDIR}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/" || die
}

src_install() {
	dodir /opt/"${MY_PN}"
	insinto /opt/"${MY_PN}"
	doins "${MY_P}.jar"

	doicon "${FILESDIR}/jd_icon_128.png"
	domenu "${FILESDIR}/jd-gui.desktop"

#	echo -e "#!/bin/sh\njava -jar /opt/${MY_PN}/${MY_P}.jar >/dev/null 2>&1 &\n" > "${MY_PN}"
#	dobin "${MY_PN}"

	newbin - ${PN} <<-EOF
		#!/bin/sh
		export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
		java -jar /opt/${MY_PN}/${MY_P}.jar >/dev/null 2>&1 &
	EOF

}
