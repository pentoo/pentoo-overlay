# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="firefox"
inherit mozilla-addon

MOZ_FILEID="229626"
DESCRIPTION="SQL Inject Me is the Exploit-Me tool used to test for SQL Injection vulnerabilities."
HOMEPAGE="http://labs.securitycompass.com/exploit-me"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${MOZ_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
