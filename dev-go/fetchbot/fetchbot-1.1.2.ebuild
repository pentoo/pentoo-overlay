# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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

DESCRIPTION="Simple, flexible web crawler that follows robots.txt policies and crawl delays"
HOMEPAGE="https://github.com/PuerkitoBio/fetchbot"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-go/robotstxt-go:="
RDEPEND=""
