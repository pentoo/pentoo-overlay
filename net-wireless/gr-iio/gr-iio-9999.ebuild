# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1 git-r3

DESCRIPTION="GNU Radio IIO Blocks"
HOMEPAGE="https://github.com/analogdevicesinc/gr-iio"

EGIT_REPO_URI="https://github.com/analogdevicesinc/gr-iio"
KEYWORDS=""

SLOT="0"

RDEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	net-libs/libiio:=
	net-libs/libad9361:="

DEPEND="${RDEPEND}
	sys-devel/flex:=
	sys-devel/bison:="
