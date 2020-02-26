# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="a tool for generating freedesktop-compliant menus"
HOMEPAGE="https://github.com/pentoo/genmenu"
EGIT_REPO_URI="https://github.com/pentoo/genmenu.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

#gnome-base/gnome-menus"
DEPEND=">=dev-python/lxml-1.3.6"
RDEPEND="${DEPEND}"

src_install() {
	local DEST="/usr/share/fern-wifi-cracker"
	insinto /usr/
	doins -r "${S}"/src/share
	dosym "${DEST}/resources/icon.png" /usr/share/pixmaps/fern-wifi-cracker.png
	chown -R root:root "${ED}"
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
