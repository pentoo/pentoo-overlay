# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit versionator python git-2 autotools

DESCRIPTION=""
HOMEPAGE="http://code.ettus.com/redmine/ettus/projects/uhd/wiki"

EGIT_REPO_URI="https://github.com/steve-m/gr-air-modes"
#EGIT_REPO_URI="git://github.com/threeme3/gr-air-modes.git"
KEYWORDS="~*"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND="dev-util/cmake
	net-wireless/gnuradio
	net-wireless/gr-baz"
RDEPEND="net-wireless/gnuradio
	 net-wireless/gr-baz"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-dependency-tracking
}

src_install() {
	default_src_install
	cd src/python
	python_convert_shebangs 2 *.py
	exeinto /usr/bin
	doexe *.py
}
