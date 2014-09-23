# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

DESCRIPTION="Morse code decoder"
HOMEPAGE="http://morse2txt.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="gnome-base/libgnomeui
	gnome-base/libgnome
	x11-libs/gtk+
	dev-libs/atk
	x11-libs/gdk-pixbuf
	dev-libs/glib"
RDEPEND="${DEPEND}"
