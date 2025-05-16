# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Promises/A+ implementation for Python"
HOMEPAGE="https://github.com/syrusakbary/promise"
SRC_URI="https://github.com/syrusakbary/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? (
	dev-python/py[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-benchmark[${PYTHON_USEDEP}]
)"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

src_prepare() {
	use test && eapply "${FILESDIR}/${P}_fix-test.patch"
	eapply_user
}

python_test() {
	epytest --benchmark-disable --ignore tests/test_awaitable.py --deselect tests/test_issues.py::test_issue_9_safe
}
