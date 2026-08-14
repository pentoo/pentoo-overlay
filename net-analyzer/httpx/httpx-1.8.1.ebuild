# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast and multi-purpose HTTP toolkit that allows running multiple probes"
HOMEPAGE="https://docs.projectdiscovery.io/opensource/httpx/overview"

SRC_URI="
	https://github.com/projectdiscovery/httpx/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/techtruth/pentoo-overlay/releases/download/httpx-${PV}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

BDEPEND=">=dev-lang/go-1.24.0"

src_compile() {
	einfo "Building httpx"
	ego build -trimpath -o httpx ./cmd/httpx || die "Failed to build httpx"
}

src_install() {
	dobin httpx
}
