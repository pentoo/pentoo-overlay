# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="SSL testing tool written in perl"
#HOMEPAGE="http://sites.google.com/site/lupingreycorner/"
HOMEPAGE="https://github.com/stephenbradshaw/ssltest"
SRC_URI="https://raw.githubusercontent.com/stephenbradshaw/ssltest/390212c507baa868866f4b4aa572ad8ed5116dd3/ssltest.pl -> ${P}.pl"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-perl/IO-Socket-SSL"

S="${WORKDIR}"/${PN}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}"/"${P}".pl "${S}"/ssltest
}

src_prepare() {
	default
	epatch "${FILESDIR}"/"${PV}"-friendly500.patch
}

src_install() {
	dobin ssltest
}
