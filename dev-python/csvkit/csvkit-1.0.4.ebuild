# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A suite of utilities for converting to and working with CSV files"
HOMEPAGE="https://csvkit.readthedocs.org/"
SRC_URI="https://github.com/wireservice/csvkit/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="MIT"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/ordereddict[${PYTHON_USEDEP}]' python2_7)
	dev-python/agate[${PYTHON_USEDEP}]
	dev-python/agate-dbf[${PYTHON_USEDEP}]
	dev-python/agate-excel[${PYTHON_USEDEP}]
	dev-python/agate-sql[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
