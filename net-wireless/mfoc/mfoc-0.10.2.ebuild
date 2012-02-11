# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils autotools

DESCRIPTION="Mifare Classic Offline Cracker"
HOMEPAGE="https://code.google.com/p/nfc-tools/wiki/mfoc"
SRC_URI="https://nfc-tools.googlecode.com/files/mfoc-0.10.2.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-libnfc-1.5.1.patch || die
	eautoreconf
}

src_install() {
	DESTDIR="${D}" emake install || die
}
