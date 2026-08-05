# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/processors"

inherit cmake github-archive

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
