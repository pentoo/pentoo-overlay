# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO="https://github.com/ccie18643/PyTCP"

inherit distutils-r1 pypi

DESCRIPTION="An alternative to Python's standard-library ipaddress module"
HOMEPAGE="https://pypi.org/project/pmd-net-addr/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6[${PYTHON_USEDEP}]
"
