# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit cmake-utils git-r3

DESCRIPTION="GNU Radio block that decodes Automatic Information System for shipborne position reporting"
HOMEPAGE="https://github.com/bistromath/gr-ais"

EGIT_REPO_URI="https://github.com/bistromath/gr-ais.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"
DEPEND=">=net-wireless/gnuradio-3.7.6:=
	dev-libs/boost:=
	dev-util/cppunit
	dev-lang/swig:*
	doc? ( app-doc/doxygen )"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_ENABLE_DOXYGEN=YES="$(usex doc)"
		-DCMAKE_INSTALL_PREFIX=/usr/share
	)
	cmake-utils_src_configure
}
