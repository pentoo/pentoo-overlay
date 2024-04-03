# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="py.test fixture for benchmarking code"
HOMEPAGE="https://github.com/ionelmc/pytest-benchmark"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/elasticsearch[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with Elasticsearch" dev-python/elasticsearch
	optfeature "support of histogram" dev-python/pygal dev-python/pygaljs
	optfeature "support of aspect" dev-python/aspectlib
}
