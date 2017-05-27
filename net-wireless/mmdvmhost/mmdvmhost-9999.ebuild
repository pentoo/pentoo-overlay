# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils

DESCRIPTION="The host program for MMDVM"
HOMEPAGE="https://github.com/g4klx/MMDVMHost"
SRC_URI=""
EGIT_REPO_URI="https://github.com/g4klx/MMDVMHost.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dmr-access-control"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	use dmr-access-control || epatch "${FILESDIR}"/disable-dmr-accesscontrol.patch
	sed -i -e "s#CFLAGS  = -g -O3 -Wall#CFLAGS  = ${CFLAGS}#" -e "s#LDFLAGS = -g#LDFLAGS = ${LDFLAGS}#" Makefile
	eapply_user
}

src_install() {
	dobin MMDVMHost
	
	insinto /etc
	doins MMDVM.ini
}
