# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature

DESCRIPTION="Organizational asset discovery tool with 20+ plugins."
HOMEPAGE="https://github.com/praetorian-inc/pius https://github.com/praetorian-inc"
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

local pius_ldflags=(
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
		-ldflags "${pius_ldflags[*]}" \
		-o ${PN} \
		./cmd/${PN}
}

src_install() {
	newbin ${PN} ${PN}

	# Man page if present.
	if [[ -f man/man1/pius.1 ]]; then
		doman man/man1/pius.1
	fi
}

pkg_postinst() {
	elog ""
	optfeature "google-dorks capabilities." www-client/chromium
	elog ""
	elog "More informations:"
	elog "  - Documentation: https://github.com/praetorian-inc/pius"
	elog ""
}
