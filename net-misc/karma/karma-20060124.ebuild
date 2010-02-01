# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="MITM framework for wifi"
HOMEPAGE="http://www.theta44.org/karma"
SRC_URI="http://www.theta44.org/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/ruby
	net-misc/dhcp
	net-wireless/wireless-tools
	net-libs/libpcap"

src_compile() {
	epatch "${FILESDIR}"/karma-gentoo.patch || die
	cd src
	emake || die
	mv karma karma-monitor
}

src_install() {
	dosbin bin/karma
	dosbin src/karma-monitor
	dodir /usr/lib/karma
	cp -pPR modules "${D}"usr/lib/karma || die
	insinto /etc/karma
	doins etc/*.xml
	dodoc README src/misc/*
}
