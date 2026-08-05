# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/redasm"

CPM_VERSION="0.43.1"

CPM_PACKAGES=(
	"QHexView Dax89/QHexView v5.1.3"
)

inherit github-archive cpm-cmake

DESCRIPTION="The OpenSource Disassembler"
HOMEPAGE+=" https://redasm.dev/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	dev-libs/libredasm
	dev-qt/qtbase:6[widgets]
"
RDEPEND="${DEPEND}
	dev-db/redasm-kb
	dev-libs/redasm-analyzers
	dev-libs/redasm-processors
	dev-libs/redasm-commands
	dev-libs/redasm-loaders
"
