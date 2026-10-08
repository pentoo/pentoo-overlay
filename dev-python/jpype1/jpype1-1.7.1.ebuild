# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A Python to Java bridge"
HOMEPAGE="https://github.com/jpype-project/jpype https://pypi.org/project/jpype1/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64"

RDEPEND="dev-python/packaging[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-python/scikit-build-core-0.9
	dev-java/ant
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
