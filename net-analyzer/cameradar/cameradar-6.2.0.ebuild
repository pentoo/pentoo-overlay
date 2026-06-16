# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

P_VENDOR="https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz"

DESCRIPTION="Cameradar hacks its way into RTSP videosurveillance cameras"
HOMEPAGE="https://github.com/ullaakut/cameradar"

SRC_URI="https://github.com/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${P_VENDOR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome X"

RDEPEND=">=dev-lang/go-1.12"
DEPEND="${RDEPEND}"

src_compile() {
	env GOBIN="${S}/bin" go install ./... ||
		die "compile failed"
}

src_install() {
	dobin bin/cameradar
	insinto /usr/share/cameradar/
	doins internal/dict/assets/{credentials.json,routes}
}

# https://github.com/Ullaakut/cameradar/wiki/Configuration-Reference/
# FIXME: configure a shell launcher file with ENV varilables:
# CUSTOM_CREDENTIALS=/usr/share/cameradar/credentials.json
# CUSTOM_ROUTES=/usr/share/cameradar/routes
