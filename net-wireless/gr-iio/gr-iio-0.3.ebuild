# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="GNU Radio IIO Blocks"
HOMEPAGE="https://github.com/analogdevicesinc/gr-iio"
SRC_URI="https://github.com/analogdevicesinc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

SLOT="0"

RDEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	net-libs/libiio:=
	net-libs/libad9361-iio:="

DEPEND="${RDEPEND}
	sys-devel/flex:=
	sys-devel/bison:="
