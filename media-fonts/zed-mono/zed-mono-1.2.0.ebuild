# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"
inherit font

DESCRIPTION="The Zed Mono typeface, custom built from Iosevka"
HOMEPAGE="https://github.com/zed-industries/zed-fonts"
SRC_URI="https://github.com/zed-industries/zed-fonts/releases/download/${PV}/zed-mono-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~riscv x86"

BDEPEND="app-arch/unzip"
