# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/kb"
GITHUB_COMMIT="6794839fa3caeb092711e729e7206c3a0f8da1ea"

inherit cmake github-snapshot

DESCRIPTION="Redasm Knowledge Base"
HOMEPAGE="https://github.com/redasm-dev/kb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

#DEPEND="
#	dev-libs/libredasm
#	dev-qt/qtbase:6[widgets]
#"
