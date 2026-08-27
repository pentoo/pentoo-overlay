# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python implementation of core osmocom utilities / protocols"
HOMEPAGE="
	https://osmocom.org/projects/pyosmocom/wiki
	https://gerrit.osmocom.org/plugins/gitiles/python/pyosmocom
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/gsm0338[${PYTHON_USEDEP}]
	>=dev-python/construct-2.9.51[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-argparse
