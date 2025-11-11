# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A basic implementation of the __geo_interface__"
HOMEPAGE="https://pypi.org/project/pygeoif/"
SRC_URI="https://github.com/cleder/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# error even in the pipeline of the project due to a healthcheck
	tests/hypothesis/test_polygon.py
)

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-autodoc-typehints \
	dev-python/typing-extensions
