# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion

DESCRIPTION="a tool for generating freedesktop-compliant menus"
HOMEPAGE="http://trac.pentoo.ch/projects/catalyst/wiki/Genmenu"
ESVN_REPO_URI="https://pentoo.googlecode.com/svn/${PN}/trunk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
DEPEND=">=dev-python/lxml-1.3.6
	gnome-base/gnome-menus"
RDEPEND="${DEPEND}"

src_install() {
#	find "${S}" -type d -name ".svn" -exec rm -rf '{}' \; 2> /dev/null
	insinto /usr/share/
	doins -r "${S}"/src/share/genmenu
	chown -R root:root "${D}"
	dobin src/bin/genmenu.py src/bin/launch
}

pkg_postinst() {
	einfo
	einfo "Run genmenu.py to regenerate the main Pentoo menu for a local user"
	einfo "See -h for more options"
	einfo
	einfo "After that you might need to run env-update"
	einfo "and then restart X.org to reflect changes"
}
