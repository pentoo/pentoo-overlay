# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

ZAP_SCRIP_PLUGIN="scrip-alpha-2.zap"
ZAP_DIFF_PLUGIN="diff-alpha-2.zap"
ZAP_WEBSOCKET_PLUGIN="websocket-release-2.zap"
ZAP_SERVERSENDEVENTS_PLUGIN="sse-alpha-2.zap"
ZAP_BEANSHELL_PLUGIN="beanshell-beta-1.zap"
ZAP_FUZZDB_PLUGIN="fuzzdb-release-2.zap"
ZAP_SPIDERAJAX_PLUGIN="spiderAjax-beta-3.zap"
ZAP_CONSOLE_PLUGIN="scripts-beta-5.zap"

DESCRIPTION="An easy to use integrated penetration testing tool for finding vulnerabilities in web applications"
HOMEPAGE="http://code.google.com/p/zaproxy/"
SRC_URI="https://zaproxy.googlecode.com/files/${MY_P}_Linux.tar.gz
	plugins? (
		https://zap-extensions.googlecode.com/files/${ZAP_SCRIP_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_DIFF_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_WEBSOCKET_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_SERVERSENDEVENTS_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_BEANSHELL_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_FUZZDB_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_SPIDERAJAX_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_CONSOLE_PLUGIN}
	) "
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+plugins"

RDEPEND="|| ( virtual/jre:1.7 virtual/jdk:1.7 )"
#	app-fuzz/fuzzdb"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	#workaround not to upack *.jar files
	unpack "${MY_P}_Linux.tar.gz"
}

src_prepare() {
	if use plugins ; then

		cp "${DISTDIR}/${ZAP_SCRIP_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_DIFF_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_WEBSOCKET_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SERVERSENDEVENTS_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_BEANSHELL_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_FUZZDB_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SPIDERAJAX_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_CONSOLE_PLUGIN}" "${S}"/plugin
	fi
	#use external tool
#	rm -r "${S}"/fuzzers/fuzzdb-1.09 || die "Unable to remove fuzzdb"
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${D}/opt/${PN}" || die "Install failed!"
	dosym /opt/"${PN}"/zap.sh /usr/bin/zaproxy
#	dosym /usr/share/fuzzdb /opt/"${PN}"/fuzzers/fuzzdb-1.09
}

pkg_postinst() {
	einfo "You need to make sure that jdk/jre v7 is enabled by running:"
	einfo "eselect java-vm set [user|system] [vm]"
}
