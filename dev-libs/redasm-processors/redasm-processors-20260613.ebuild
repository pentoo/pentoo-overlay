# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/processors"
GITHUB_COMMIT="06e59983ff0ff0397d1cce104c5eb0cac95d8598"

inherit cmake github-snapshot

DESCRIPTION="Redasm Processor plugins"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	dev-libs/libredasm
	>=dev-libs/capstone-6.0.0_alpha7
	dev-libs/zydis
"
RDEPEND="${DEPEND}"
