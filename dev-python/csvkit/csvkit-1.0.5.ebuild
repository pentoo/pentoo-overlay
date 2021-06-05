# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A suite of utilities for converting to and working with CSV files"
HOMEPAGE="https://csvkit.readthedocs.org/"
SRC_URI="https://github.com/wireservice/csvkit/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/agate[${PYTHON_USEDEP}]
	dev-python/agate-dbf[${PYTHON_USEDEP}]
	dev-python/agate-excel[${PYTHON_USEDEP}]
	dev-python/agate-sql[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
