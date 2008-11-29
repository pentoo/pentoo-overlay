# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Yet Another RSS Reader - A KDE/Gnome system tray rss aggregator"
HOMEPAGE="http://yarss.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
RESTRICT="nomirror"

SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

RDEPEND="dev-perl/Locale-gettext
	dev-perl/XML-RSS
	dev-perl/gtk2-trayicon
	dev-perl/gtk2-gladexml
	dev-perl/gnome2-vfs-perl
	>=dev-perl/gnome2-perl-0.94"

DEPEND=""

DOCS="ChangeLog TODO README"

src_install() {
    make DESTDIR=${D} install
    dodoc ${DOCS}
}
