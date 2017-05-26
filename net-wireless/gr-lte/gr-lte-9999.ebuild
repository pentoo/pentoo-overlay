# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit cmake-utils git-r3

DESCRIPTION="GNU Radio block for LTE signals"
HOMEPAGE="https://github.com/kit-cel/gr-lte"

EGIT_REPO_URI="https://github.com/kit-cel/gr-lte.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	>=sci-libs/fftw-3.3.4:=
	dev-util/cppunit
	dev-lang/swig:*"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr/share
	)
	cmake-utils_src_configure
}
