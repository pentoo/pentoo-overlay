# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A library for efficient use of ATI CAL with C++"
HOMEPAGE="http://calpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-util/ati-app-sdk-bin
	 x11-drivers/ati-drivers"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/cmake
"

src_configure() {
	cmake-utils_src_configure
}
