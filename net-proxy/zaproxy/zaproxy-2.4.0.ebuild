# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

ZAP_EXTENSIONS_URI="https://github.com/zaproxy/zap-extensions/releases/download/2.4"
ZAP_ASCAN_PLUGIN="ascanrules-release-17.zap"
ZAP_PSCAN_PLUGIN="pscanrules-release-12.zap"
ZAP_DIRLIST1_PLUGIN="directorylistv1-release-2.zap"
ZAP_DIRLIST23_PLUGIN="directorylistv2_3-release-2.zap"
ZAP_DIRLIST23LC_PLUGIN="directorylistv2_3_lc-release-2.zap"
ZAP_SCRIPT_PLUGIN="scripts-beta-14.zap"
ZAP_DIFF_PLUGIN="diff-beta-5.zap"
ZAP_WEBSOCKET_PLUGIN="websocket-release-9.zap"
ZAP_SSE_PLUGIN="sse-alpha-8.zap"
ZAP_BEANSHELL_PLUGIN="beanshell-beta-5.zap"
ZAP_FUZZDB_PLUGIN="fuzzdb-release-3.zap"
ZAP_QUICK_PLUGIN="quickstart-release-15.zap"
ZAP_PLUG_HACK="plugnhack-beta-8.zap"
ZAP_SQLMAP_PLUGIN="sqliplugin-beta-8.zap"
ZAP_WAPPALYZER_PLUGIN="wappalyzer-alpha-4.zap"

ZAP_SELEN_PLUGIN="selenium-release-1.zap"
ZAP_SPIDERAJAX_PLUGIN="spiderAjax-release-12.zap"
ZAP_ZEST_PLUGIN="zest-beta-18.zap"

DESCRIPTION="An easy to use integrated penetration testing tool for finding vulnerabilities in web applications"
HOMEPAGE="https://github.com/zaproxy/zaproxy"
SRC_URI="https://github.com/zaproxy/zaproxy/releases/download/${PV}/ZAP_${PV}_Core.tar.gz
	plugins? (
		${ZAP_EXTENSIONS_URI}/${ZAP_ASCAN_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_PSCAN_PLUGIN}

		${ZAP_EXTENSIONS_URI}/${ZAP_DIRLIST1_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_DIRLIST23_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_DIRLIST23LC_PLUGIN}

		${ZAP_EXTENSIONS_URI}/${ZAP_SCRIPT_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_DIFF_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_WEBSOCKET_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_SSE_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_BEANSHELL_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_FUZZDB_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_QUICK_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_PLUG_HACK}
		${ZAP_EXTENSIONS_URI}/${ZAP_SQLMAP_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_WAPPALYZER_PLUGIN}

		${ZAP_EXTENSIONS_URI}/${ZAP_SELEN_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_SPIDERAJAX_PLUGIN}
		${ZAP_EXTENSIONS_URI}/${ZAP_ZEST_PLUGIN}
	) "

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+plugins"

RDEPEND="|| ( virtual/jre:1.7 virtual/jdk:1.7 )"
#	app-fuzz/fuzzdb"

S="${WORKDIR}/${MY_P}"

#src_unpack() {
#	#workaround not to upack *.jar plugin files
#	unpack "${MY_P}_Lite.tar.gz"
#}

src_prepare() {
	if use plugins ; then
		rm "${S}"/plugin/ascanrules-*.zap
		rm "${S}"/plugin/diff-*.zap
		rm "${S}"/plugin/plugnhack-*.zap
		rm "${S}"/plugin/pscanrules-*.zap
		rm "${S}"/plugin/quickstart-*.zap

		cp "${DISTDIR}/${ZAP_ASCAN_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_PSCAN_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_DIRLIST1_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_DIRLIST23_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_DIRLIST23LC_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SCRIPT_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_DIFF_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_WEBSOCKET_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SSE_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SCRIP_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_BEANSHELL_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_FUZZDB_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SPIDERAJAX_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_QUICK_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_PLUG_HACK}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SQLMAP_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_ZEST_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_WAPPALYZER_PLUGIN}" "${S}"/plugin
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
	einfo "Zaproxy requires jdk/jre >=7. Make sure it is enabled by running the following:"
	einfo "eselect java-vm set [user|system] [vm]"
}
