# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/core"
GITHUB_COMMIT="0b6a20111970469131615e13f3801de836834ae3"
CPM_VERSION="0.42.3"
# Format: name repository tag
CPM_PACKAGES=(
	"tomlc17 cktan/tomlc17 R20260501"
)

inherit github-snapshot cpm-cmake

DESCRIPTION="Redasm engine core library"
HOMEPAGE="https://github.com/redasm-dev/core https://redasm.dev/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="dev-db/sqlite"
RDEPEND="${DEPEND}"
