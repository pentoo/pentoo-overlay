# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A Firefox extensions from the firecat framework."
HOMEPAGE="http://www.security-database.com/toolswatch/FireCAT-Firefox-Catalog-of,302.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-plugins/add-n-edit-cookies
	x11-plugins/firebug
	x11-plugins/foxyproxy
	x11-plugins/hackbar
	x11-plugins/httpfox
	x11-plugins/live-http-headers
	x11-plugins/no-referer
	x11-plugins/showip
	x11-plugins/sql-inject-me
	x11-plugins/sql-injection
	x11-plugins/multiproxy-switch
	x11-plugins/tamper-data
	x11-plugins/user-agent-switcher
	x11-plugins/xss-me"
DEPEND="${RDEPEND}"
