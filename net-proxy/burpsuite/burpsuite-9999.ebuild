# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

DESCRIPTION="Interactive proxy for attacking and debugging web applications"
HOMEPAGE="https://portswigger.net/burp/"

S=${WORKDIR}
LICENSE="BURP"
SLOT="0"

# https://portswigger.net/burp/releases
# https://portswigger.net/burp/releases/professional/latest
MY_PV=${PV/_rc/}
if [ "${PV}" != "9999" ]; then
	if [[ "${PN}" == *"pro" ]]; then
		MY_P="burpsuite_pro_v${MY_PV}.jar"
		SRC_URI="https://portswigger.net/burp/releases/download?product=pro&version=${MY_PV}&type=Jar  -> ${MY_P}"
	else
		MY_P="burpsuite_community_v${MY_PV}.jar"
		SRC_URI="https://portswigger.net/burp/releases/download?product=community&version=${MY_PV} -> ${MY_P}"
	fi

	if [[ "${PV}" == *"_rc" ]]; then
		KEYWORDS="~amd64 ~x86"
	else
		KEYWORDS="amd64 x86"
	fi
fi

BDEPEND="app-arch/zip"
#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="virtual/jre:21"

pkg_setup() {
	if [[ "${PV}" == *9999 ]]; then
		eerror "9999 is a template, do not use it"
		die
	fi
}

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

	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png
}
