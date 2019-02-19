# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN}.sh"
MY_PV="${PV/_rc/rc}"

DESCRIPTION="Tool to check TLS/SSL cipher support"
HOMEPAGE="https://testssl.sh/"
SRC_URI="https://github.com/drwetter/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
#SRC_URI="https://codeload.github.com/drwetter/testssl.sh/tar.gz/${MY_PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-shells/bash[net]
	dev-libs/openssl-bad
	net-dns/bind-tools
	sys-apps/util-linux
	sys-libs/ncurses:0
	sys-process/procps
"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_prepare() {
	default
	sed -i ${PN}.sh \
		-e 's|TESTSSL_INSTALL_DIR="${TESTSSL_INSTALL_DIR:-""}"|TESTSSL_INSTALL_DIR="/"|' \
		-e 's|$TESTSSL_INSTALL_DIR/etc/|&testssl/|g' || die

	sed -i ${PN}.sh \
		-e 's|OPENSSL="$1/openssl"|OPENSSL="$1/openssl-bad"|' || die
}

src_install() {
	dodoc CHANGELOG.stable-releases.txt CREDITS.md Readme.md
#	dodoc openssl-rfc.mappping.html

	dobin ${PN}.sh

	insinto /etc/${PN}
	doins etc/*
}
