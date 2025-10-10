# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Multiprotocol credentials bruteforcer/password"
HOMEPAGE="https://github.com/evilsocket/legba"

SRC_URI="amd64? ( fetch+https://github.com/evilsocket/legba/releases/download/${PV}/legba-${PV}-linux-x86_64.tar.gz )
		arm64? ( fetch+https://github.com/evilsocket/legba/releases/download/${PV}/legba-${PV}-linux-arm64.tar.gz )
		arm? ( fetch+https://github.com/evilsocket/legba/releases/download/${PV}/legba-${PV}-linux-armv7.tar.gz )
		"

S="${WORKDIR}/legba-${PV}-linux-x86_64"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~arm"

BDEPEND="app-arch/unzip"
QA_PREBUILD="*"

src_install() {
	newbin "legba" "${PN}"
}

