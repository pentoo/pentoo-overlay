# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

DESCRIPTION="a client for the Apple Filing Protocol"
HOMEPAGE="https://github.com/simonvetter/afpfs-ng"
SRC_URI="https://raw.githubusercontent.com/simonvetter/afpfs-ng/master/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	DESTDIR="${D}" emake install
	insinto /usr/include/$PN
	doins include/* || die "failed to install headers"
}
