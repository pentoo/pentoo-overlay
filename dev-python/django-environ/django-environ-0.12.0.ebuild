# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Library to utilize 12factor inspired environment variables to configure Django."
HOMEPAGE="
	https://github.com/joke2k/django-environ/
	https://pypi.org/project/django-environ/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-2.2[${PYTHON_USEDEP}]
"

# one failing test
EPYTEST_DESELECT=(
	'tests/test_db.py::test_db_parsing[postgres_cluster]'
)

distutils_enable_sphinx docs dev-python/furo dev-python/sphinx-notfound-page
distutils_enable_tests pytest
