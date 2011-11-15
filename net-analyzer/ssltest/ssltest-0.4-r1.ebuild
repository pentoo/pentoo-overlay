# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="SSL testing tool written in perl"
HOMEPAGE="http://sites.google.com/site/lupingreycorner/"
SRC_URI="http://sites.google.com/site/lupingreycorner/${P}.pl"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-Socket-SSL"

S="${WORKDIR}"/${PN}

src_unpack() {
	einfo "Nothing to unpack"
	mkdir "${S}"
	cp "${DISTDIR}"/"${P}".pl "${S}"/ssltest
}

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-friendly500.patch
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin ssltest || die "install failed"
}
