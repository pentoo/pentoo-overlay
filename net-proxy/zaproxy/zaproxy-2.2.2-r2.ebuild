# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

ZAP_ASCAN_PLUGIN="ascanrules-release-13.zap"
ZAP_PSCAN_PLUGIN="pscanrules-release-8.zap"
ZAP_SCRIPT_PLUGIN="scripts-beta-10.zap"
ZAP_DIFF_PLUGIN="diff-beta-3.zap"
ZAP_WEBSOCKET_PLUGIN="websocket-release-7.zap"
ZAP_SSE_PLUGIN="sse-alpha-6.zap"
ZAP_SCRIP_PLUGIN="scrip-alpha-5.zap"
ZAP_BEANSHELL_PLUGIN="beanshell-beta-3.zap"
ZAP_FUZZDB_PLUGIN="fuzzdb-release-2.zap"
ZAP_SPIDERAJAX_PLUGIN="spiderAjax-beta-9.zap"
ZAP_QUICK_PLUGIN="quickstart-release-13.zap"
ZAP_PLUG_HACK="plugnhack-beta-4.zap"
ZAP_SQLMAP_PLUGIN="sqliplugin-beta-5.zap"
ZAP_ZEST_PLUGIN="zest-beta-11.zap"

DESCRIPTION="An easy to use integrated penetration testing tool for finding vulnerabilities in web applications"
HOMEPAGE="http://code.google.com/p/zaproxy/"
SRC_URI="mirror://sourceforge/zaproxy/${MY_P}_Linux.tar.gz
	plugins? (
		mirror://sourceforge/zaproxy/${ZAP_ASCAN_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_PSCAN_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_SCRIPT_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_DIFF_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_WEBSOCKET_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_SSE_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_SCRIP_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_BEANSHELL_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_FUZZDB_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_SPIDERAJAX_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_QUICK_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_PLUG_HACK}
		mirror://sourceforge/zaproxy/${ZAP_SQLMAP_PLUGIN}
		mirror://sourceforge/zaproxy/${ZAP_ZEST_PLUGIN}
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
		rm "${S}"/plugin/zest-*.zap

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
		cp "${DISTDIR}/${ZAP_PLUG_HACK}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_SQLMAP_PLUGIN}" "${S}"/plugin
		cp "${DISTDIR}/${ZAP_ZEST_PLUGIN}" "${S}"/plugin

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
