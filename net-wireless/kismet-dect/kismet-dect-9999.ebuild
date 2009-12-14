# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion

DESCRIPTION="DECT plugin for kismet"
HOMEPAGE="https://dedected.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=net-wireless/kismet-2009.11.1-r1
	net-wireless/dedected"

ESVN_REPO_URI="https://dedected.org/svn/trunk/kismet-dect"

src_prepare() {
	# build with custom CFLAGS
	sed -i -e "s/-g/${CFLAGS}/g" server_module/Makefile
	sed -i -e "s/-fPIC/${CFLAGS} -fPIC/g" client_module/Makefile
}

src_compile() {
	make KIS_SRC_DIR="/usr/include/kismet/" -C client_module || die "failed to compile client module"
	make KIS_SRC_DIR="/usr/include/kismet/" -C server_module || die "failed to compile server module"
}

src_install() {
	make KIS_DEST_DIR="${D}/usr/" -C client_module install || die "failed to install client module"
	make KIS_DEST_DIR="${D}/usr/" -C server_module install || die "failed to install server module"
}
