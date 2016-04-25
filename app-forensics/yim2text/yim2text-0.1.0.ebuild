# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="A python script to decode yahoo instant message archive files"
HOMEPAGE="http://www.1vs0.com/tools.html"
SRC_URI="http://www.1vs0.com/code/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

src_install() {
	dobin ${PN}
	python_fix_shebang "${ED}"usr/bin
}
