# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_/}"

DESCRIPTION="Tool to check TLS/SSL cipher support"
HOMEPAGE="https://testssl.sh/"
SRC_URI="https://github.com/drwetter/testssl.sh/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/testssl.sh-${MY_PV}"

LICENSE="GPL-2 bundled-openssl? ( openssl )"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+bundled-openssl kerberos"
REQUIRED_USE="bundled-openssl? ( || ( amd64 x86 ) )"

# openssl-bad provides 197 ciphers
# bundled-openssl has 183 ciphers
# openssl (gentoo) 80 ciphers only
RDEPEND="
	app-shells/bash[net]
	net-dns/bind-tools
	sys-apps/util-linux
	sys-libs/ncurses:0
	sys-process/procps
	bundled-openssl? (
		kerberos? (
			sys-libs/zlib
			virtual/krb5
		)
	)
	!bundled-openssl? ( dev-libs/openssl-bad )"

QA_PREBUILT="opt/${PN}/*"

pkg_setup() {
	if use amd64; then
		if use kerberos; then
			BUNDLED_OPENSSL="openssl.Linux.x86_64.krb"
		else
			BUNDLED_OPENSSL="openssl.Linux.x86_64"
		fi
	elif use x86; then
		BUNDLED_OPENSSL="openssl.Linux.i686"
	fi
}

src_prepare() {
	default
	sed -i ${PN}.sh \
		-e 's|TESTSSL_INSTALL_DIR="${TESTSSL_INSTALL_DIR:-""}"|TESTSSL_INSTALL_DIR="/"|' \
		-e 's|$TESTSSL_INSTALL_DIR/etc/|&testssl/|g' || die

	#Gentoo hack find_openssl_binary(), we do it better
	if use bundled-openssl; then
		sed -i ${PN}.sh \
			-e "s|OPENSSL=\"\$1/openssl\"|OPENSSL=\"/opt/${PN}/${BUNDLED_OPENSSL}\"|" || die
	else
		sed -i ${PN}.sh \
			-e 's|OPENSSL="$1/openssl"|OPENSSL="$1/openssl-bad"|' || die
	fi
}

src_install() {
	dodoc CHANGELOG.md CREDITS.md Readme.md
	dodoc openssl-iana.mapping.html

	dobin ${PN}.sh

	insinto /etc/${PN}
	doins etc/*

	if use bundled-openssl; then
		exeinto /opt/${PN}
		use amd64 && doexe bin/${BUNDLED_OPENSSL}
	fi
}
