# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Base58 and Base58Check implementation compatible with the bitcoin network"
HOMEPAGE="
	https://pypi.org/project/base58/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/py
		dev-python/pyhamcrest
		dev-python/pytest-benchmark
	)
"

distutils_enable_tests pytest
