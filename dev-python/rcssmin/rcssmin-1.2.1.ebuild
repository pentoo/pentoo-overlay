# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="RCSSmin is a CSS minifier"
HOMEPAGE="http://opensource.perlig.de/rcssmin/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_sphinx docs/_userdoc dev-python/furo
distutils_enable_tests pytest
