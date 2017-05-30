# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit cmake-utils git-r3

DESCRIPTION="GNU Radio block for Tire Pressure Monitor tools"
HOMEPAGE="https://github.com/jboone/gr-tpms"

EGIT_REPO_URI="https://github.com/jboone/gr-tpms.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	dev-util/cppunit
	dev-lang/swig:*"

RDEPEND="${DEPEND}"

src_configure() {
	sed -i '0,/include\/tpms/s/include\/tpms/include\/gnuradio\/tpms/' ${WORKDIR}/${P}/CMakeLists.txt || die 'sed failed'
	cmake-utils_src_configure
}
