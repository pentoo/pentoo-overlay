# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/processors"
GITHUB_COMMIT="4cfdfa64137ac162d31784ae40be8cf695f4fd32"

inherit cmake github-snapshot

DESCRIPTION="Redasm Processor plugins"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	>=dev-libs/capstone-6.0.0_alpha7
	dev-libs/zydis
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/redasm-processors-system-libs.patch" )
