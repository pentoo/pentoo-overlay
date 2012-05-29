# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools subversion

DESCRIPTION="Gnuradio baz"
HOMEPAGE="http://wiki.spench.net/wiki/Gr-baz"
ESVN_REPO_URI="http://svn.spench.net/main/gr-baz/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="net-wireless/gnuradio"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-dependency-tracking
}

src_install() {
	default_src_install
	insinto /usr/share/${PN}
	doins samples/*.grc
}
