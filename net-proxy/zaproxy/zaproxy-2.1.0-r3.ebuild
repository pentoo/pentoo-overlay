# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

ZAP_ASCAN_PLUGIN="ascanrules-release-9.zap"
ZAP_PSCAN_PLUGIN="pscanrules-release-4.zap"
ZAP_SCRIPT_PLUGIN="scripts-beta-7.zap"
ZAP_DIFF_PLUGIN="diff-alpha-2.zap"
ZAP_WEBSOCKET_PLUGIN="websocket-release-6.zap"
ZAP_SSE_PLUGIN="sse-alpha-5.zap"
ZAP_SCRIP_PLUGIN="scrip-alpha-2.zap"
ZAP_BEANSHELL_PLUGIN="beanshell-beta-2.zap"
ZAP_FUZZDB_PLUGIN="fuzzdb-release-2.zap"
ZAP_SPIDERAJAX_PLUGIN="spiderAjax-beta-5.zap"
ZAP_QUICK_PLUGIN="quickstart-release-12.zap"

DESCRIPTION="An easy to use integrated penetration testing tool for finding vulnerabilities in web applications"
HOMEPAGE="http://code.google.com/p/zaproxy/"
SRC_URI="https://zaproxy.googlecode.com/files/${MY_P}_Linux.tar.gz
	plugins? (
		https://zap-extensions.googlecode.com/files/${ZAP_ASCAN_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_PSCAN_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_SCRIPT_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_DIFF_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_WEBSOCKET_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_SSE_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_SCRIP_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_BEANSHELL_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_FUZZDB_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_SPIDERAJAX_PLUGIN}
		https://zap-extensions.googlecode.com/files/${ZAP_QUICK_PLUGIN}
	) "
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+plugins"

RDEPEND="|| ( virtual/jre:1.7 virtual/jdk:1.7 )"
#	app-fuzz/fuzzdb"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	#workaround not to upack *.jar plugin files
	unpack "${MY_P}_Linux.tar.gz"
}

src_prepare() {
	if use plugins ; then
		rm "${S}"/plugin/ascanrules-*.zap
		rm "${S}"/plugin/spiderAjax-*.zap
		rm "${S}"/plugin/websocket-*.zap
		rm "${S}"/plugin/quickstart-*.zap
		rm "${S}"/plugin/sse-*.zap

		cp "${DISTDIR}/${ZAP_ASCAN_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_PSCAN_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SCRIPT_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_DIFF_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_WEBSOCKET_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SSE_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SCRIP_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_BEANSHELL_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_FUZZDB_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SPIDERAJAX_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_QUICK_PLUGIN}" "${S}"/plugin
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
	einfo "Zaproxy requires jdk/jre v7. Make sure it is enabled by running the following:"
	einfo "eselect java-vm set [user|system] [vm]"
}
