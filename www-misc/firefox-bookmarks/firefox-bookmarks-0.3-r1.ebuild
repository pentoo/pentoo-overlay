# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Firefox bookmarks for the Pento ISO only"
HOMEPAGE="http://code.google.com/p/pentoo"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} || (
	>=www-client/firefox-bin-15.0.1
	>=www-client/firefox-15.0.1
)"

S="${WORKDIR}"
MOZ_PN="firefox"

src_prepare() {
	cp "${FILESDIR}/pentoo-bookmarks-${PV}.html" bookmarks.html || die
}

src_compile(){
	return
}

src_install(){
	declare MOZILLA_FIVE_HOME=/opt/${MOZ_PN}

	insinto ${MOZILLA_FIVE_HOME}/defaults/profile/
	doins bookmarks.html
}
