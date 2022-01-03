# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python Data Validation for Humans"
HOMEPAGE="https://github.com/kvesteri/validators"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
LICENSE="MIT"
SLOT="0"
IUSE="test"

CDEPEND="${PYTHON_DEPS}"
RDEPEND="${CDEPEND}
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]"

DEPEND="${CDEPEND}
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}] )"

src_test() {
	pytest -vv || die "tests failed"
}
