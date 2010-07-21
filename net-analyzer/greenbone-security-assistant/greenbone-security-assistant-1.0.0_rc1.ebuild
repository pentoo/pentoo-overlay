# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit versionator eutils

MY_P=${P/_rc/.rc}

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/756/${MY_P}.tar.gz"
EAPI="2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-util/cmake
	net-libs/gnutls
	>=net-libs/libmicrohttpd-0.4.2
	>=net-analyzer/openvas-libraries-3.0.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
#	sed -i 's|cmake|cmake -DCMAKE_BUILD_TYPE=RELEASE|g' Makefile || die
	#remove -Werror so it doesn't error for fun
	#sed -i s/'add_definitions (-Werror)'//g src/CMakeLists.txt || die "Failed to remove -Werror"
	#remove fatal error from build system when unneeded doxygen is missing
	sed -i s/'message (FATAL_ERROR "Doxygen is required to build the HTML docs.")'//g doc/CMakeLists.txt
	cmake -DCMAKE_INSTALL_PREFIX=/usr
}

src_install() {
	DESTDIR="${D}" emake install || die "failed to install"
#	find "${D}" -name '*.la' -delete
	dodoc ChangeLog CHANGES || die
}
