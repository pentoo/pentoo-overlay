# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit cmake-utils git-r3

DESCRIPTION="GNU Radio block for decoding packets transmitted by Elster R2S smart meters"
HOMEPAGE="https://github.com/argilo/gr-elster"

EGIT_REPO_URI="https://github.com/argilo/gr-elster.git"
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
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr/share
	)
	cmake-utils_src_configure
}
