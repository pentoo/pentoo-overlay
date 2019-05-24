# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="ZAP"
MY_PV="D-2019-05-23"
MY_P="${MY_PN}_${MY_PV}"

#Workaround to sava zap ext under different filename
#https://github.com/zaproxy/zap-extensions/releases/tag/2.7
#https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-2.7.xml
#https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions-dev.xml

ZAP_EXTENSIONS_URI="https://github.com/zaproxy/zap-extensions/releases/download/2.7"

declare -a PLUGINS
PLUGINS[0]="ascanrules;release;32"
PLUGINS[1]="pscanrules;release;23"
PLUGINS[2]="bruteforce;beta;7"
PLUGINS[3]="scripts;beta;24"
PLUGINS[4]="diff;beta;8"
PLUGINS[5]="websocket;release;18"
PLUGINS[6]="quickstart;release;25"
PLUGINS[7]="selenium;release;14"
PLUGINS[8]="zest;beta;28"
PLUGINS[9]="invoke;beta;9"
PLUGINS[10]="fuzz;beta;10"

for i in "${PLUGINS[@]}"
do
	arr=(${i//;/ })
	#url-base versioning workaround
	PL_URL="${PL_URL} ${ZAP_EXTENSIONS_URI}/${arr[0]}-${arr[1]}-${arr[2]}.zap -> ${P}-${arr[0]}-${arr[1]}-${arr[2]}.zap"
done

DESCRIPTION="The OWASP Zed Attack Proxy for finding vulnerabilities in web applications"
HOMEPAGE="https://github.com/zaproxy/zaproxy"
SRC_URI="https://github.com/zaproxy/zaproxy/releases/download/w2019-05-23/${MY_PN}_WEEKLY_${MY_PV}.zip -> ${P}.zip"
#	plugins? ( $PL_URL ) "

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="plugins"
IUSE=""

RESTRICT="mirror"

RDEPEND="|| ( virtual/jre virtual/jdk )
	!virtual/jre:1.6
	!virtual/jdk:1.6"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	use plugins && einfo "plugins are bundled in this version.\n Please disable the use flag"

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
