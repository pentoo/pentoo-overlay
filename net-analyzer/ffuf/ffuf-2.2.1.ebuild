# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast web fuzzer written in Go"
HOMEPAGE="https://github.com/ffuf/ffuf"

SRC_URI="https://github.com/ffuf/ffuf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/ffuf-${PV}"

RESTRICT="network-sandbox"

src_compile() {
	ego build -o ffuf . 
}
src_install() {
	dobin ffuf
}
