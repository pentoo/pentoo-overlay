# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#Workaround to sava zap ext under different filename
#https://github.com/zaproxy/zap-extensions/releases/tag/2.7
#https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-2.7.xml
#https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-dev.xml

#https://github.com/zaproxy/zap-extensions/releases/download/selenium-v15.0.0/selenium-release-15.0.0.zap
ZAP_EXTENSIONS_URI="https://github.com/zaproxy/zap-extensions/releases/download/"

declare -a PLUGINS
PLUGINS[0]="ascanrules;release;33"
PLUGINS[1]="pscanrules;release;24"
PLUGINS[2]="bruteforce;beta;8"
PLUGINS[3]="scripts;beta;25"
PLUGINS[4]="diff;beta;9"
PLUGINS[5]="websocket;release;20"
PLUGINS[6]="quickstart;release;26"
PLUGINS[7]="selenium;release;15.0.0"
PLUGINS[8]="zest;beta;29"
#PLUGINS[9]="invoke;beta;9"
PLUGINS[9]="fuzz;beta;11"
PLUGINS[10]="spiderAjax;release;23.0.0"
PLUGINS[11]="wappalyzer;alpha;13"

PLUGIN_HUD_PV="0.6.0"
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

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+plugins"

RESTRICT="mirror"

RDEPEND="|| ( virtual/jre virtual/jdk )
	!virtual/jre:1.6
	!virtual/jdk:1.6"

S="${WORKDIR}/ZAP_${PV}"

src_prepare() {
	if use plugins ; then
		rm "${S}"/plugin/ascanrules-*.zap
		rm "${S}"/plugin/pscanrules-*.zap
		rm "${S}"/plugin/bruteforce-*.zap
		rm "${S}"/plugin/diff-*.zap
#		rm "${S}"/plugin/plugnhack-*.zap
		rm "${S}"/plugin/quickstart-*.zap
		rm "${S}"/plugin/invoke-*.zap

		for i in "${PLUGINS[@]}"
		do
			arr=(${i//;/ })
			cp "${DISTDIR}/${P}-${arr[0]}-${arr[1]}-${arr[2]}.zap" "${S}"/plugin/${arr[0]}-${arr[1]}-${arr[2]}.zap
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
	dosym /opt/"${PN}"/zap.sh /usr/bin/zaproxy
}

pkg_postinst() {
	einfo "Zaproxy requires jdk/jre >=7. Make sure it is enabled by running the following:"
	einfo "eselect java-vm set [user|system] [vm]"
}
