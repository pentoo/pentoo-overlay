# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit subversion

DESCRIPTION="Provides basic bluetooth support in kismet"
HOMEPAGE="http://ubertooth.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=net-wireless/kismet-2011.03.2-r1 \
		>=dev-libs/libbtbb-0.5 \
		>=dev-libs/libusb-1.0.0"

ESVN_REPO_URI="https://ubertooth.svn.sourceforge.net/svnroot/ubertooth/trunk/host"

#S="${WORKDIR}/kismet/plugin-ubertooth"

src_prepare() {
	epatch "${FILESDIR}/makefile.patch"
}

src_compile() {
	cd "${WORKDIR}/${P}/kismet/plugin-ubertooth"
	emake KIS_SRC_DIR="/usr/include/kismet/"
}

src_install() {
	cd "${WORKDIR}/${P}/kismet/plugin-ubertooth"
	emake DESTDIR="${ED}" LIBDIR="$(get_libdir)" KIS_SRC_DIR="/usr/include/kismet/" KIS_DEST_DIR="${D}/usr/" install
}
