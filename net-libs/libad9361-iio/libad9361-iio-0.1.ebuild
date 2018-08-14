# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="IIO AD9361 library for filter design and handling, multi-chip sync, etc."
HOMEPAGE="https://github.com/analogdevicesinc/libad9361-iio"
SRC_URI="https://github.com/analogdevicesinc/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="net-libs/libiio:="
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i '/include(FindGit OPTIONAL)/d' CMakeLists.txt
	cmake-utils_src_prepare
	eapply_user
}
