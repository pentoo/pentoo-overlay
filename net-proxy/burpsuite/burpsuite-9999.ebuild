# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

DESCRIPTION="Interactive proxy for attacking and debugging web applications"
HOMEPAGE="https://portswigger.net/burp/"

# https://portswigger.net/burp/releases
# https://portswigger.net/burp/releases/professional/latest
MY_PV=${PV/_rc/}
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
elif [[ "${PV}" == *"_rc" ]]; then
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS="amd64 x86"
fi

LICENSE="BURP"
SLOT="0"
IUSE=""

BDEPEND="app-arch/zip"
DEPEND=""
RDEPEND=">=virtual/jre-11"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}"
}

src_prepare() {
	default
	#clean out the cruft
	zip -d burpsuite*.jar chromium-win*.zip || die
	zip -d burpsuite*.jar chromium-macos*.zip || die
}

src_install() {
	java-pkg_jarinto /opt/"${PN}"
	java-pkg_newjar "${MY_P}"
	java-pkg_dolauncher "${PN}" --java_args "-Xmx2G -Dawt.useSystemAAFontSettings=on --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED"

	if [[ "${PN}" == *"pro" ]]; then
		domenu "${FILESDIR}"/${PN}.desktop
		doicon "${FILESDIR}"/${PN}.png
	fi
}
