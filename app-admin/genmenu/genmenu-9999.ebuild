# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit subversion

DESCRIPTION="Genmenu is a tool for generating freedesktop-compliant menus"
HOMEPAGE="https://trac.pentoo.ch/projects/catalyst/wiki/Genmenu"
ESVN_REPO_URI="https://www.pentoo.ch/svn/${PN}/trunk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""
DEPEND="=dev-python/lxml-1.3.6
	gnome-base/gnome-menus"
RDEPEND="${DEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	insinto /usr/share/
	find "${S}" -type d -name ".svn" | xargs rm -R
        doins -r "${S}"/src/share/genmenu
        chown -R root:root ${D}
 	dobin src/bin/genmenu.py src/bin/launch
}

pkg_postinst() {
	einfo "Once you've run genmenu.py, you might need to env-update"
	einfo "then restart X.org to reflect the P2TERM changes"
}
