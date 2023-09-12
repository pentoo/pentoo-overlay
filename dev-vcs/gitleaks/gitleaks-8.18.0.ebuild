# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGO_PN="github.com/zricethezav/gitleaks"
inherit go-module

DESCRIPTION="Audit git repos for secrets"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI="https://github.com/zricethezav/gitleaks/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

src_compile() {
	einfo "COMPILE ==========="
	ego build
}

src_install() {
	einfo "INSTALL ==========="
	dobin ${PN}
#	default
}
