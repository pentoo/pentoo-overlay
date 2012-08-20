# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"

#inherit autotools subversion python
inherit autotools git-2 python

DESCRIPTION="Gnuradio baz"
HOMEPAGE="http://wiki.spench.net/wiki/Gr-baz"
#ESVN_REPO_URI="http://svn.spench.net/main/gr-baz/"
EGIT_REPO_URI="https://github.com/balint256/gr-baz.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="net-wireless/gnuradio"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

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
