# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/andybalholm/cascadia"

EGO_VENDOR=(
	"golang.org/x/net cbe0f9307d01 github.com/golang/net"
)

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	inherit golang-vcs-snapshot
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"
fi
inherit golang-build

DESCRIPTION="CSS selector library in Go"
HOMEPAGE="https://github.com/andybalholm/cascadia/"
LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""
