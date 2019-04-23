# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Fast web fuzzer written in Go"
HOMEPAGE="https://github.com/ffuf/ffuf"

SRC_URI="
	amd64? ( https://github.com/ffuf/ffuf/releases/download/v${PV}/ffuf_${PV}_linux_amd64.tar.gz -> ${P}-amd64.tar.gz )
	arm? ( https://github.com/ffuf/ffuf/releases/download/v${PV}/ffuf_${PV}_linux_armv6.tar.gz -> ${P}-arm.tar.gz )
	arm64? ( https://github.com/ffuf/ffuf/releases/download/v${PV}/ffuf_${PV}_linux_arm64.tar.gz -> ${P}-arm64.tar.gz )
	x86? ( https://github.com/ffuf/ffuf/releases/download/v${PV}/ffuf_${PV}_linux_386.tar.gz -> ${P}-x86.tar.gz )"

KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
RDEPEND="!net-analyzer/ffuf"
QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	dobin ${PN%%-bin}
	dodoc README.md
}

pkg_postinst() {
	elog "\nSee documentation: https://github.com/ffuf/ffuf#usage\n"
}
