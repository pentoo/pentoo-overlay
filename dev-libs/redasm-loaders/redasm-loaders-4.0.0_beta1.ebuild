# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/loaders"

inherit cmake github-archive

DESCRIPTION="Redasm Loader plugins"
HOMEPAGE="https://github.com/redasm-dev/loaders https://redasm.dev/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="dev-libs/libredasm"
RDEPEND="${DEPEND}"
