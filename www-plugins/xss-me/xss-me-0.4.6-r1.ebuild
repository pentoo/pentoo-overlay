# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${PN/-/_}-${PV}-fx"
DESCRIPTION="Firefox extension to test for reflected cross-site-scripting vulnerabilities."
HOMEPAGE="http://labs.securitycompass.com/exploit-me/xss-me"
SRC_URI="mirror://mozilla/addons/7598/${FFP_XPI_FILE}.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
