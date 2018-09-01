# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="IIO AD9361 library for filter design and handling, multi-chip sync, etc."
HOMEPAGE="https://github.com/analogdevicesinc/libad9361-iio"

EGIT_REPO_URI="https://github.com/analogdevicesinc/libad9361-iio"
KEYWORDS=""

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="net-libs/libiio:="

DEPEND="${RDEPEND}"
