# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Unsupervised text tokenizer focused on computational efficiency"
HOMEPAGE="https://github.com/vkcom/youtokentome"
SRC_URI="https://github.com/VKCOM/YouTokenToMe/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/YouTokenToMe-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${P}-fix-test.patch"
)

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/tabulate[${PYTHON_USEDEP}]
		sci-ml/tokenizers
	)
"

distutils_enable_tests pytest
