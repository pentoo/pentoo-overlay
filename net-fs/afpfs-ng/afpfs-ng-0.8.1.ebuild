# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools

DESCRIPTION="a client for the Apple Filing Protocol"
HOMEPAGE="http://sites.google.com/site/alexthepuffin/"
SRC_URI="mirror://sourceforge/$PN/$P.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	DESTDIR="${D}" emake install
	insinto /usr/include/$PN
	doins include/* || die "failed to install headers"
}
