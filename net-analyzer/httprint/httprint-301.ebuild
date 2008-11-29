# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/httprint/httprint-301.ebuild,v 1.1.1.1 2006/03/09 21:57:23 grimmlin Exp $

inherit eutils

DESCRIPTION="HTTP fingerprinter tool"
HOMEPAGE="http://net-square.com/${PN}/"

MY_P="${PN}_${PV}"

SRC_URI="http://net-square.com/${PN}/${PN}_linux_${PV}.zip"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="allsigs"

DEPEND="dev-libs/openssl"

S=${WORKDIR}/${MY_P}/linux

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	use allsigs && sed -i -e '/^#[a-zA-Z0-9]/ s/^#//g' signatures.txt
	insinto /opt/"${MY_P}"/
	doins httprint nmapportlist.txt signatures.txt
	insinto /opt/"${MY_P}"/images/
	doins images/*
	dodoc input.txt readme.txt
}
