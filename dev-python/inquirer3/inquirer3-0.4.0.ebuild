# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Collection of common interactive command line user interfaces"
HOMEPAGE="https://github.com/guysalt/python-inquirer3"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/blessed-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/readchar-4.0.5[${PYTHON_USEDEP}]
	>=dev-python/python-editor-1.0.4[${PYTHON_USEDEP}]
	>=dev-python/coloredlogs-15.0.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
