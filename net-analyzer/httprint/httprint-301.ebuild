# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_P="${PN}_${PV}"

DESCRIPTION="HTTP fingerprinter tool"
HOMEPAGE="http://net-square.com/httprint.html"
SRC_URI="http://net-square.com/_assets/${PN}_linux_${PV}.zip"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="allsigs"

DEPEND=""
RDEPEND="amd64? ( sys-libs/glibc[multilib] )"

S="${WORKDIR}"/${MY_P}/linux

#src_compile() {
#	einfo "Nothing to compile"
#}

src_install() {
	use allsigs && sed -i -e '/^#[a-zA-Z0-9]/ s/^#//g' signatures.txt
	insinto /opt/${MY_P}/
	doins nmapportlist.txt signatures.txt
	exeinto /opt/${MY_P}/
	doexe $PN
	insinto /opt/${MY_P}/images/
	doins images/*
	dodoc input.txt readme.txt
}
