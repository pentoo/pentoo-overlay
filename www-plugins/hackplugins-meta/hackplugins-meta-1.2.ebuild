# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI="5"

DESCRIPTION="Collection of browser's plugins for application security testing"
HOMEPAGE="http://pentoo.ch"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="+firefox"

PDEPEND="
	firefox? (
		www-plugins/foxyproxy
		www-plugins/noscript
		www-plugins/user-agent-switcher-revived
		www-plugins/wappalyzer
		)"

#	www-plugins/firebug
#	www-plugins/ringleader
#	www-plugins/sql-inject-me
#	www-plugins/xss-me
#	www-plugins/cookies_exportimport
#	www-plugins/adblock_plus
#	www-plugins/downthemall
#	www-plugins/exif_viewer
#	www-plugins/hackbar
#	www-plugins/httpfox
#	www-plugins/live-http-headers
#	www-plugins/multi_links
#	www-plugins/proxy_selector
#	www-plugins/showip
#	www-plugins/status_4_evar
#	www-plugins/web_developer
