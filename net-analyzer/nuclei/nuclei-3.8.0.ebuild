# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module flag-o-matic

DESCRIPTION="Simple and configurable vulnerability scanner based on YAML templates"
HOMEPAGE="https://github.com/projectdiscovery/nuclei https://projectdiscovery.io"
SRC_URI="https://github.com/projectdiscovery/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+templates"

RESTRICT="test"

RDEPEND="
	templates? ( net-analyzer/nuclei-templates )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/go
"

QA_PREBUILD="*"

S="${WORKDIR}/${PN}-${PV}"

go-module_set_globals
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

	# Flag inspired by Arch PKGBUILD:
	# 	- https://github.com/BlackArch/blackarch/blob/d9f24f83f5632f16bf3727e8788069717e83312d/packages/nuclei/PKGBUILD#L4

	local nuclei_ldflags=(
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
		-ldflags "${nuclei_ldflags[*]}" \
		-o ${PN} \
		./cmd/${PN}
}

src_install() {
	newbin ${PN} ${PN}

	# Documentation
	dodoc README.md CONTRIBUTING.md || true

	# Man page si présente
	if [[ -f man/man1/nuclei.1 ]]; then
        doman man/man1/nuclei.1
    fi
}

pkg_postinst() {
	elog "More informations:"
	elog "  - Documentation: https://docs.projectdiscovery.io/tools/nuclei/"
	elog "  - Templates: https://github.com/projectdiscovery/nuclei-templates"
	elog ""
}
