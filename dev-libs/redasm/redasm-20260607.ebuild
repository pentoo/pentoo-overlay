# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="redasm-dev/core"
GITHUB_COMMIT="94857719737c6e10ee782199318b7b19217bf4b6"
CPM_VERSION="0.42.1"
# name repository tag
CPM_PACKAGES=(
	"tomlc17 cktan/tomlc17 R20260501"
)

inherit cmake github-snapshot cpm-cmake

DESCRIPTION="Redasm engine core library"
HOMEPAGE="https://redasm.io https://github.com/redasm-dev/core"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="dev-db/sqlite"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/redasm-system-sqlite3.patch" )

cpm_configure() {
	mycmakeargs+=(
		-DCMAKE_INSTALL_INCLUDEDIR="/usr/include"
	)
}
