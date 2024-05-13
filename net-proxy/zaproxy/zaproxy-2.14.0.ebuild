# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-pkg-2

# Workaround to sava zap ext under different filename
# https://github.com/zaproxy/zap-extensions/releases/tag/2.7
# https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-2.7.xml
# https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-dev.xml (search: "<file><plugin>")

# https://github.com/zaproxy/zap-extensions/releases/download/selenium-v15.0.0/selenium-release-15.0.0.zap
ZAP_EXTENSIONS_URI="https://github.com/zaproxy/zap-extensions/releases/download/"

#https://www.zaproxy.org/docs/statistics/top-addons-last-month/

declare -a PLUGINS
PLUGINS+=("accessControl;alpha;10")
PLUGINS+=("ascanrules;release;65")
PLUGINS+=("alertFilters;release;20")
PLUGINS+=("authhelper;beta;0.12.0")
PLUGINS+=("automation;beta;0.37.0")
PLUGINS+=("bruteforce;beta;15")
PLUGINS+=("callhome;release;0.11.0")
PLUGINS+=("commonlib;release;1.23.0")
PLUGINS+=("scripts;release;44")
PLUGINS+=("diff;beta;14")
PLUGINS+=("websocket;release;30")
PLUGINS+=("graphql;alpha;0.23.0")
PLUGINS+=("selenium;release;15.21.0")
PLUGINS+=("zest;beta;43")
PLUGINS+=("fuzz;beta;13.12.0")
PLUGINS+=("custompayloads;beta;0.13.0")
PLUGINS+=("sqliplugin;beta;15")
PLUGINS+=("spiderAjax;release;23.18.0")
PLUGINS+=("exim;beta;0.8.0")
PLUGINS+=("webdriverlinux;release;78")
PLUGINS+=("network;beta;0.15.0")
PLUGINS+=("openapi;beta;39")
PLUGINS+=("pscanrules;release;57")
PLUGINS+=("postman;alpha;0.3.0")
PLUGINS+=("quickstart;release;45")
PLUGINS+=("replacer;release;16")
PLUGINS+=("reports;release;0.31.0")
PLUGINS+=("requester;beta;7.5.0")
PLUGINS+=("retire;release;0.34.0")
PLUGINS+=("scripts;release;45.1.0")
PLUGINS+=("soap;beta;22")
PLUGINS+=("spider;release;0.10.0")
PLUGINS+=("wappalyzer;release;21.33.0")

# https://github.com/zaproxy/zap-hud/releases
PLUGIN_HUD_PV="0.18.0"
PLUGIN_HUD_URL="https://github.com/zaproxy/zap-hud/releases/download/v${PLUGIN_HUD_PV}/hud-beta-${PLUGIN_HUD_PV}.zap"

for i in "${PLUGINS[@]}"
do
	declare -a arr
	arr=(${i//;/ })
	PL_URL="${PL_URL} ${ZAP_EXTENSIONS_URI}/${arr[0]}-v${arr[2]}/${arr[0]}-${arr[1]}-${arr[2]}.zap -> ${P}-${arr[0]}-${arr[1]}-${arr[2]}.zap"
done

DESCRIPTION="The OWASP Zed Attack Proxy for finding vulnerabilities in web applications"
HOMEPAGE="https://github.com/zaproxy/zaproxy"
#SRC_URI="https://github.com/zaproxy/zaproxy/releases/download/v2.8.0/ZAP_${PV}_Core.zip
SRC_URI="https://github.com/zaproxy/zaproxy/releases/download/v${PV}/ZAP_${PV}_Linux.tar.gz
		plugins? ( $PL_URL $PLUGIN_HUD_URL ) "

S="${WORKDIR}/ZAP_${PV}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+plugins"

#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="|| ( >=virtual/jre-11:* virtual/jdk:* )"

src_prepare() {
	if use plugins ; then
		for i in "${PLUGINS[@]}"
		do
			arr=(${i//;/ })
			rm "${S}"/plugin/"${arr[0]}-*.zap"
			cp "${DISTDIR}/${P}-${arr[0]}-${arr[1]}-${arr[2]}.zap" "${S}"/plugin/${arr[0]}-${arr[1]}-${arr[2]}.zap || die "failed to copy"
		done
		cp "${DISTDIR}/"${PLUGIN_HUD} "${S}"/plugin/

	fi
	#use external tool
#	rm -r "${S}"/fuzzers/fuzzdb-1.09 || die "Unable to remove fuzzdb"
	eapply_user
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${D}/opt/${PN}" || die "Install failed!"
	dosym -r "${EPREFIX}"/opt/"${PN}"/zap.sh /usr/bin/zaproxy
}
