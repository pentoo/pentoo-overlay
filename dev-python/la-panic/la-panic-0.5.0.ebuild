# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
#PYPI_PN="la-panic"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="iPhone kernel panic parser"
HOMEPAGE="https://gitlab.com/yanivhasbanidev/la_panic"
#SRC_URI="https://files.pythonhosted.org/packages/85/28/757e1ccd939162caa27c8a6173d490deb986c38a7fd73fe2f264f6d7485d/la-panic-0.5.0.tar.gz"
#S="${WORKDIR}/${PYPI_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"



#distutils_enable_tests pytest
