# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Integrated process monitor for developing and reloading daemons"
HOMEPAGE="https://github.com/Pylons/hupper/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# ignore tests that need interaction
EPYTEST_IGNORE=(
	tests/test_it.py
)

distutils_enable_tests pytest

# no doc, the package is using the theme of the organization that has not
# packages in Gentoo or Pentoo (https://github.com/Pylons/pylons_sphinx_theme)
# distutils_enable_sphinx docs
