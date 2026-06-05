# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="An 010 template interpreter for Python"
HOMEPAGE="https://github.com/bannsec/pfp/tree/stegoveritas"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# no in the overlay, but if it's added one day
# !!dev-python/pfp
RDEPEND="${PYTHON_DEPS}
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/intervaltree[${PYTHON_USEDEP}]
	>=dev-python/stegoveritas-py010parser-0.1.5[${PYTHON_USEDEP}]
"

