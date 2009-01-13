# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mozextension multilib

# 				https://addons.mozilla.org/fr/firefox/downloads/file/7473/domainfinder-0.3-fx.xpi
#				https://addons.mozilla.org/en-US/firefox/downloads/file/15850/hostip.info_geolocation_plugin-0.4.3.3-fx+mz+ns+sm+fl.xpi

DESCRIPTION="FireCAT is a Firefox Framework Map collection of the most useful security oriented extensions."
HOMEPAGE="http://www.security-database.com/toolswatch/FireCAT-Firefox-Catalog-of,302.html"
SRC_URI="recon? (https://addons.mozilla.org/en-US/firefox/downloads/file/31241/shazou-2.1-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/41571/showip-0.8.10r22b0272-fx+mz+sm.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/31098/asnumber-1.0beta9-fx.xpi)
		security? (https://addons.mozilla.org/en-US/firefox/downloads/file/30978/hackbar-1.3.2-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/33806/tamper_data-10.1.0-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/28118/live_http_headers-0.14-fx+sm.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/28580/httpfox-0.8.2-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/33291/add_n_edit_cookies-0.2.1.3-fx+mz.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/35382/sql_injection-1.2-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/38926/xss_me-0.4.0-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/38927/sql_inject_me-0.4.0-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/39364/access_me-0.2.1-fx.xpi)
		proxy? (https://addons.mozilla.org/en-US/firefox/downloads/file/530/switchproxy_tool-1.4.1-fx+mz+tb.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/44657/foxyproxy-2.8.11-fx.xpi
				https://addons.mozilla.org/en-US/firefox/downloads/file/29649/pow_--_plain_old_webserver-0.1.8-fx+tb+sb.xpi)
		mining? (http://bibirmer.ourtoolbar.com/Storage/22/27/CT273922/Downloads/firefox/Bibirmer.xpi)
		editors? (https://addons.mozilla.org/en-US/firefox/downloads/file/44490/firebug-1.3.0-fx.xpi)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="recon proxy editors security network misc mining"

RDEPEND="|| (
	>=www-client/mozilla-firefox-bin-3.0.0
	>=www-client/mozilla-firefox-3.0.0
)"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	for x in $A
	do
		xpi_unpack "${x}"
	done
}

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	declare MOZILLA_FIVE_HOME
	for x in `ls "${S}/"`
	do
		if has_version '>=www-client/mozilla-firefox-1.5.0.7'; then
			MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
			xpi_install "${S}"/"${x}"
		fi
		if has_version '>=www-client/mozilla-firefox-bin-1.5.0.7'; then
			MOZILLA_FIVE_HOME="/opt/firefox"
			xpi_install "${S}"/"${x}"
		fi
	done
}
