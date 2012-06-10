# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="${PV/_/}"

DESCRIPTION="a cross-platform library for capturing video from webcams and other video capture devices"
HOMEPAGE="http://libvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pkgconfig"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
