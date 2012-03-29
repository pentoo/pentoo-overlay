# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit subversion

DESCRIPTION="Provides basic bluetooth support in kismet"
HOMEPAGE="http://ubertooth.sourceforge.net/"
SRC_URI=""
ESVN_REPO_URI="https://ubertooth.svn.sourceforge.net/svnroot/ubertooth/trunk/host"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

DEPEND=">=net-wireless/kismet-2011.03.2-r1 \
		>=net-libs/libbtbb-9999 \
		>=dev-libs/libusb-1.0.0"
RDEPEND="${DEPEND}"


src_compile() {
	if has_version =net-wireless/kismet-9999; then
		cd "${WORKDIR}/${P}/kismet/plugin-ubertooth-phyneutral"
	else
		cd "${WORKDIR}/${P}/kismet/plugin-ubertooth"
	fi
	emake KIS_SRC_DIR="/usr/include/kismet/"
}

src_install() {
	if has_version =net-wireless/kismet-9999; then
		cd "${WORKDIR}/${P}/kismet/plugin-ubertooth-phyneutral"
	else
		cd "${WORKDIR}/${P}/kismet/plugin-ubertooth"
	fi
	emake DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" KIS_SRC_DIR="/usr/include/kismet/" KIS_DEST_DIR="${D}/usr/" install
}
