# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Collection of firefox extensions for application security auditing and assessment."
# HOMEPAGE="http://www.security-database.com/toolswatch/FireCAT-Firefox-Catalog-of,302.html"
HOMEPAGE="http://www.firecat.fr/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	www-plugins/firebug
	www-plugins/foxyproxy
	www-plugins/hackbar
	www-plugins/httpfox
	www-plugins/live-http-headers
	www-plugins/noscript
	www-plugins/showip
	www-plugins/tamper-data
	www-plugins/user-agent-switcher
	www-plugins/sql-inject-me
	www-plugins/xss-me"
DEPEND="${RDEPEND}"
