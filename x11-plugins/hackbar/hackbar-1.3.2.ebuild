# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mozextension multilib eutils

# 				https://addons.mozilla.org/fr/firefox/downloads/file/7473/domainfinder-0.3-fx.xpi
#				https://addons.mozilla.org/en-US/firefox/downloads/file/15850/hostip.info_geolocation_plugin-0.4.3.3-fx+mz+ns+sm+fl.xpi

MY_P="${P}-fx"
DESCRIPTION="FireCAT is a Firefox Framework Map collection of the most useful security oriented extensions."
HOMEPAGE="http://www.security-database.com/toolswatch/FireCAT-Firefox-Catalog-of,302.html"
SRC_URI=" https://addons.mozilla.org/en-US/firefox/downloads/file/30978/${MY_P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
	>=www-client/mozilla-firefox-bin-3.0.0
	>=www-client/mozilla-firefox-3.0.0
)"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	xpi_unpack $A
	epatch "${FILESDIR}/${MY_P}.patch"
}

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	declare MOZILLA_FIVE_HOME
	if has_version '>=www-client/mozilla-firefox-1.5.0.7'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
		xpi_install "${S}/${MY_P}"
	fi
	if has_version '>=www-client/mozilla-firefox-bin-1.5.0.7'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${S}/${MY_P}"
	fi
}
