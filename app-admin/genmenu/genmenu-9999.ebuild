# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion

DESCRIPTION="a tool for generating freedesktop-compliant menus"
HOMEPAGE="https://code.google.com/p/pentoo/source/browse"
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
	einfo "The genmenu has been updated."
	einfo "You should run the following command to regenerate the main Pentoo menu for a local user:"
	einfo "E17:  genmenu.py -e"
	einfo "Xfce: genmenu.py -x"
	einfo "KDE:  genmenu.py -k"
	einfo
	einfo "See -h for more options"
}
