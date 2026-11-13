# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Static analyzer and safe VBA emulator for malicious Office documents"
HOMEPAGE="https://github.com/debugactiveprocess/MaldocTrace"
SRC_URI="
	https://github.com/debugactiveprocess/MaldocTrace/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/${P}/${P}-deps.tar.xz
"

S="${WORKDIR}/MaldocTrace-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

BDEPEND="dev-lang/go"

src_unpack() {
	go-module_src_unpack
}

src_compile() {
	ego build \
		-trimpath \
		-buildmode=pie \
		-mod=readonly \
		-modcacherw \
		-ldflags "-s -w -X github.com/debugactiveprocess/MaldocTrace.Version=${PV}" \
		-o ${PN} \
		./cmd/maldoctrace
}

src_install() {
	dobin ${PN}
	doman debian/maldoctrace.1
	dodoc README.md
}
