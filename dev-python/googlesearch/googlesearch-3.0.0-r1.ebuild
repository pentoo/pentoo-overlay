# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
EGO_PN=github.com/MarioVilas/googlesearch

inherit distutils-r1

KEYWORDS="amd64 ~arm64 x86"
EGIT_COMMIT="b47a156807439f5443611633e1f92f76838fde67"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="Google search from Python"
HOMEPAGE="https://github.com/MarioVilas/googlesearch"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/beautifulsoup4-4.5.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
