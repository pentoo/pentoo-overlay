# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast and multi-purpose HTTP toolkit that allows running multiple probes"
HOMEPAGE="https://github.com/projectdiscovery/httpx"

#	https://github.com/projectdiscovery/httpx/archive/refs/tags/v1.12.0.tar.gz
SRC_URI="
	https://github.com/projectdiscovery/httpx/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/pentoo/pentoo-golang-dist/releases/download/httpx-${PV}/httpx-${PV}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64"

BDEPEND=">=dev-lang/go-1.26.0:="

src_compile() {
	CGO_ENABLED=0 ego build -trimpath -o httpx ./cmd/httpx
}

src_install() {
	dobin httpx
	dodoc README.md
}
