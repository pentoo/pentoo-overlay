# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A tool to brute-force URIs and DNS subdomains"
HOMEPAGE="https://github.com/OJ/gobuster"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

src_prepare() {
	default
	local -a sed_args
	# -buildmode=pie not supported when -race is enabled
	[[ ${GOFLAGS} == *buildmode=pie* ]] && sed_args+=(
		-e 's/ -race / /'
	)
	sed  "${sed_args[@]}" -i Makefile || die
}

src_install() {
	dobin gobuster
}
