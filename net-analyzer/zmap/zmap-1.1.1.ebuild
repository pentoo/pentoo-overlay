# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils cmake-utils

DESCRIPTION="The Internet Scanner"
HOMEPAGE="https://zmap.io/index.html"
SRC_URI="https://github.com/zmap/zmap/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	dev-util/byacc
	dev-util/gengetopt"
#libgmp3-dev

CMAKE_IN_SOURCE_BUILD=1

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS CHANGELOG README

	insinto /etc/zmap
	doins ./conf/zmap.conf
	doins ./conf/blacklist.conf
}
