# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="streams is a tool for browsing, mining and processing TCP streams in pcap files"
HOMEPAGE="http://src.carnivore.it/streams/about"
SRC_URI="ftp://ftp.carnivore.it/projects/streams/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/readline
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc.patch"
}

src_configure() {
	econf --with-libreadline-includes=/usr/include/readline
}

src_install() {
	dobin src/streams
}
