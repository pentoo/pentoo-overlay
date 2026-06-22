# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/redasm"
GITHUB_COMMIT="676b11689acbced2d925ec2464250ba17df2c038"

CPM_VERSION="0.38.7"

CPM_PACKAGES=(
	"QHexView Dax89/QHexView v5.1.1"
)

inherit github-snapshot cpm-cmake

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
	dev-libs/redasm-processors
	dev-libs/redasm-commands
	dev-libs/redasm-loaders
"
