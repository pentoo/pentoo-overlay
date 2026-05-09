# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A Python toolbox for building complex digital hardware"
HOMEPAGE="https://m-labs.hk/migen/index.html"
SRC_URI="https://git.m-labs.hk/M-Labs/migen/archive/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/${PN}
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/colorama[${PYTHON_USEDEP}]
"

distutils_enable_sphinx doc dev-python/sphinx-rtd-theme

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

# one test from example is broken due to python 3.14, will be fixed in a futur
# release https://git.m-labs.hk/M-Labs/migen/issues/2
EPYTEST_DESELECT=(
	migen/test/test_examples.py::TestExamplesBasic::test_local_cd
)
