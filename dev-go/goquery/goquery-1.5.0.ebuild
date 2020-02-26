# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN=github.com/PuerkitoBio/${PN}

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="A little like that j-thing"
HOMEPAGE="https://github.com/PuerkitoBio/goquery"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-go/cascadia:=
	dev-go/go-net:="
RDEPEND=""
