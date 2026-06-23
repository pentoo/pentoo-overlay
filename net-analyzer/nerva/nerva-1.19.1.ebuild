# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast service fingerprinting CLI for 170+ protocols (TCP/UDP/SCTP)."
HOMEPAGE="https://github.com/praetorian-inc/nerva/wiki"
SRC_URI="https://github.com/praetorian-inc/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RESTRICT="test"

RDEPEND=""

DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/go
"

QA_PREBUILD="*"

GOFLAGS="-mod=mod"
export GOPROXY="https://proxy.golang.org,direct"
export GOSUMDB="sum.golang.org"

src_prepare() {
	default
}

src_unpack() {
	go-module_src_unpack
}

src_compile() {

local nerva_ldflags=(
		"-s"
		"-w"
		"-X main.Version=${PV}"
		"-X main.BuildTime=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
	)

	go build \
		-trimpath \
		-buildmode=pie \
		-mod=readonly \
		-modcacherw \
		-ldflags "${nerva_ldflags[*]}" \
		-o ${PN} \
		./cmd/${PN}
}

src_install() {
	newbin ${PN} ${PN}

	# Man page if present.
	if [[ -f man/man1/nerva.1 ]]; then
		doman man/man1/nerva.1
	fi
}

pkg_postinst() {
	elog "More informations:"
	elog "  - Documentation: https://github.com/praetorian-inc/nerva/wiki"
	elog ""
}
