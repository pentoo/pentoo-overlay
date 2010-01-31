# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="a tool for generating freedesktop-compliant menus"
HOMEPAGE="http://trac.pentoo.ch/projects/catalyst/wiki/Genmenu"
SRC_URI="http://dev.pentoo.ch/~grimmlin/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-python/lxml-1.3
	gnome-base/gnome-menus"
RDEPEND="${DEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/
	find "${S}" -type d -name ".svn" | xargs rm -R
		cp -R "${S}"/src/share "${D}"/usr/
		chown -R root:root "${D}"
	dosbin src/bin/genmenu.py src/bin/launch
}

pkg_postinst() {
	einfo "Once you've run genmenu.py, you might need to env-update"
	einfo "then restart X.org to reflect the P2TERM changes"
}
