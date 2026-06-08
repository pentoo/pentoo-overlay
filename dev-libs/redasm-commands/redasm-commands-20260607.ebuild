# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/commands"
GITHUB_COMMIT="ca93d41a33c4e1f3c4dffc9010a5631dca5cb588"

inherit cmake github-snapshot

DESCRIPTION="Redasm Command plugins"
HOMEPAGE="https://github.com/redasm-dev/commands https://redasm.dev/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="dev-libs/libredasm"
RDEPEND="${DEPEND}"
