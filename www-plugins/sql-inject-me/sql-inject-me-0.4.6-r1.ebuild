# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${PN//-/_}-${PV}-fx"
DESCRIPTION="SQL Inject Me is the Exploit-Me tool used to test for SQL Injection vulnerabilities."
HOMEPAGE="http://labs.securitycompass.com/exploit-me"
SRC_URI=" http://releases.mozilla.org/pub/mozilla.org/addons/7597/${FFP_XPI_FILE}.xpi"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
