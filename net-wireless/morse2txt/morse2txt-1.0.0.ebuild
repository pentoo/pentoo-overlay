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

DEPEND="dev-libs/atk
	dev-libs/glib
	gnome-base/libgnome
	gnome-base/libgnomeui
	sci-libs/gsl
	x11-libs/gdk-pixbuf
	x11-libs/gtk+"
RDEPEND="${DEPEND}"
