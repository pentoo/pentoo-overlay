# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO="https://github.com/ccie18643/PyTCP"

inherit distutils-r1 pypi

DESCRIPTION="The TCP/IP stack written in Python"
HOMEPAGE="https://pypi.org/project/pmd-pytcp/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/typing-extensions-4.6[${PYTHON_USEDEP}]
	dev-python/pmd-net-addr[${PYTHON_USEDEP}]
	dev-python/pmd-net-proto[${PYTHON_USEDEP}]
"
