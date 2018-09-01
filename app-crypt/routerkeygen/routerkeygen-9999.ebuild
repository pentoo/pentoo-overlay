# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="generate default WPA/WEP keys for some routers"
HOMEPAGE="https://routerkeygen.github.io/"
EGIT_REPO_URI="https://github.com/routerkeygen/routerkeygenPC.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-qt/qtscript
		dev-qt/qtnetwork
		dev-qt/qtwidgets
		dev-libs/openssl:0=
		dev-qt/qtdbus
		dev-qt/qtgui
		dev-qt/qtcore"
RDEPEND="${DEPEND}"
