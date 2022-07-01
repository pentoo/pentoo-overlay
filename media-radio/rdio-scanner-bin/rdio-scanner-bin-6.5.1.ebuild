# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Software police-like scanner with its own touch"
HOMEPAGE="https://github.com/chuot/rdio-scanner"

SRC_URI="amd64? ( https://github.com/chuot/rdio-scanner/releases/download/v${PV}/rdio-scanner-linux-amd64-v${PV}.zip )
		x86? ( https://github.com/chuot/rdio-scanner/releases/download/v${PV}/rdio-scanner-linux-386-v${PV}.zip )
		arm? ( https://github.com/chuot/rdio-scanner/releases/download/v${PV}/rdio-scanner-linux-arm-v${PV}.zip )
		arm64? ( https://github.com/chuot/rdio-scanner/releases/download/v${PV}/rdio-scanner-linux-arm64-v${PV}.zip )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
DEPEND="app-arch/unzip"

QA_PREBUILD="opt/rdio-scanner-bin/rdio-scanner-bin"
QA_FLAGS_IGNORED="opt/rdio-scanner-bin/rdio-scanner-bin"

S="${WORKDIR}"
src_install() {
	exeinto "/opt/${PN}"
	newexe rdio-scanner "${PN}"
	insinto "/usr/share/doc/${PN}-${PVR}"
	newins "rdio-scanner.pdf" "rdio-scanner-${PVR}.pdf"
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}
