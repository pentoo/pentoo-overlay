# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HASH_COMMIT="6edf3e78d06edb8d05e9663a32377ac12fca6a7f"
GITHUB_REPOSITORY="redasm-dev/redasm"
inherit cmake github-commit

DESCRIPTION="The OpenSource Disassembler"
HOMEPAGE="https://redasm.io"

LICENSE="GPL-3"
SLOT="0"
# https://github.com/redasm-dev/core/issues/14
#KEYWORDS="~amd64 ~arm64 ~x86"
#IUSE="+database"

#DEPEND="dev-cpp/doctest
#	dev-cpp/tbb
#	dev-qt/qttest:5
#	dev-qt/qtwidgets:5
#	dev-qt/qtx11extras:5
#	dev-qt/qtgui:5
#	dev-qt/qtcore:5"
#RDEPEND="${DEPEND}"
