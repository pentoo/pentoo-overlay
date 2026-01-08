# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Fast KML processing in python"
HOMEPAGE="https://pypi.org/project/fastkml/"
SRC_URI="https://github.com/cleder/fastkml/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	>=dev-python/pygeoif-1.5[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/tzdata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
