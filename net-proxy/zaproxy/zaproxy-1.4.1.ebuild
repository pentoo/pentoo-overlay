# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

ZAP_CONSOLE_PLUGIN="zap-ext-scripts-beta-3.jar"
ZAP_SPIDERAJAX_PLUGIN="zap-ext-spiderAjax-alpha-1.jar"
ZAP_PARAMPOLLUT_PLUGIN="zap-ext-servletParamPollution-alpha-1.jar"
ZAP_AUTH_PLUGIN="zap-ext-insecureauthentication-alpha-2.jar"
ZAP_VIEWSTATE_PLUGIN="zap-ext-viewStatePScan-alpha-1.jar"
ZAP_SQLINJECT_PLUGIN="zap-ext-sqlinjectionscan-alpha-3.jar"

DESCRIPTION="An easy to use integrated penetration testing tool for finding vulnerabilities in web applications"
HOMEPAGE="http://code.google.com/p/zaproxy/"
SRC_URI="http://zaproxy.googlecode.com/files/${MY_P}_Linux.tar.gz
	plugins? ( http://zap-extensions.googlecode.com/files/${ZAP_CONSOLE_PLUGIN}
		http://zap-extensions.googlecode.com/files/${ZAP_SPIDERAJAX_PLUGIN}
		http://zap-extensions.googlecode.com/files/${ZAP_PARAMPOLLUT_PLUGIN}
		http://zap-extensions.googlecode.com/files/${ZAP_AUTH_PLUGIN}
		http://zap-extensions.googlecode.com/files/${ZAP_VIEWSTATE_PLUGIN}
		http://zap-extensions.googlecode.com/files/${ZAP_SQLINJECT_PLUGIN} ) "
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+plugins"

RDEPEND="|| ( virtual/jre virtual/jdk )"

#	app-fuzz/fuzzdb"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	#workaround not to upack *.jar files
	unpack "${MY_P}_Linux.tar.gz"
}

src_prepare() {
	if use plugins ; then
	cp "${DISTDIR}/${ZAP_CONSOLE_PLUGIN}"     "${S}"/plugin
	cp "${DISTDIR}/${ZAP_SPIDERAJAX_PLUGIN}"  "${S}"/plugin
	cp "${DISTDIR}/${ZAP_PARAMPOLLUT_PLUGIN}" "${S}"/plugin
	cp "${DISTDIR}/${ZAP_AUTH_PLUGIN}"        "${S}"/plugin
	cp "${DISTDIR}/${ZAP_VIEWSTATE_PLUGIN}"   "${S}"/plugin
	cp "${DISTDIR}/${ZAP_SQLINJECT_PLUGIN}"   "${S}"/plugin
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
