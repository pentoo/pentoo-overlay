# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Firefox bookmarks for the Pento ISO only"
HOMEPAGE="https://code.google.com/p/pentoo/source/browse/firefox-bookmarks/Read.me"
SRC_URI="https://pentoo.googlecode.com/svn-history/r3822/firefox-bookmarks/mozilla.${PV}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} || (
	=www-client/firefox-bin-15.0.1
	=www-client/firefox-15.0.1
)"

S="${WORKDIR}"

pkg_setup(){
	if [ -e /root/.mozilla ]; then
		die "/root/.mozilla already exists!"
	fi
}

src_compile(){
	return
}

src_install(){
	insinto /root
	doins -r .mozilla
}
