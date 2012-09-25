# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mozextension multilib

MY_P="${PN//-/_}-${PV}-fx"
DESCRIPTION="SQL Inject Me is the Exploit-Me tool used to test for SQL Injection vulnerabilities."
HOMEPAGE="http://labs.securitycompass.com/exploit-me"
SRC_URI=" http://releases.mozilla.org/pub/mozilla.org/addons/7597/${MY_P}.xpi"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
	www-client/firefox-bin
	www-client/firefox
)"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	xpi_unpack $A
}

src_install () {
	declare MOZILLA_FIVE_HOME
	if has_version 'www-client/firefox'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
		xpi_install "${S}/${MY_P}"
	fi
	if has_version 'www-client/firefox-bin'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${S}/${MY_P}"
	fi
}
