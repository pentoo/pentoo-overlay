# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/analyzers"
GITHUB_COMMIT="b83c01d332f87422b65e68e09766e92d6b49c8ee"

inherit cmake github-archive

DESCRIPTION="Redasm Analyzer plugins"
HOMEPAGE="https://github.com/redasm-dev/analyzers https://redasm.dev/"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="dev-libs/libredasm"
RDEPEND="${DEPEND}"
