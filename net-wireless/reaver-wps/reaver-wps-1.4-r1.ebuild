# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P=${P/-wps/}

DESCRIPTION="Reaver implements a brute force attack against Wifi Protected Setup (WPS)"
HOMEPAGE="https://code.google.com/p/reaver-wps/"
SRC_URI="https://reaver-wps.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="net-libs/libpcap
	dev-db/sqlite"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}/src

src_prepare() {
	sed -i 's:/etc/reaver:/var/lib/reaver:' sql.h || die "sed Makefile failed"
}

src_install() {
	dosbin reaver
	dosym /usr/sbin/reaver /usr/sbin/reaver_wps
	dosbin wash
	insinto /var/lib/reaver/
	doins reaver.db
	cd ../docs
	dodoc README README.REAVER README.WASH
	doman reaver.1.gz
}
