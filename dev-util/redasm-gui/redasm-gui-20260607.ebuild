# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/redasm"
GITHUB_COMMIT="6edf3e78d06edb8d05e9663a32377ac12fca6a7f"

CPM_VERSION="0.38.7"

CPM_PACKAGES=(
	"QHexView Dax89/QHexView v5.1.0"
)

inherit github-snapshot cpm-cmake

DESCRIPTION="The OpenSource Disassembler"
HOMEPAGE="https://redasm.dev/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

PATCHES=(
	"${FILESDIR}/redasm-setup-compiler.patch"
	# comment() was added to QHexDelegate after v5.1.0; drop override until a
	# tagged QHexView release includes it
	"${FILESDIR}/redasm-qhexview-compat.patch"
)

DEPEND="
	dev-libs/libredasm
	dev-qt/qtbase:6[widgets]
"
