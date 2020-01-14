# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Editable interval tree data structure for Python 2 and 3"
HOMEPAGE="https://pypi.org/project/intervaltree/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#forked due to Gentoo bug:
#https://bugs.gentoo.org/705382
RDEPEND=">=dev-python/sortedcontainers-2.0[${PYTHON_USEDEP}]"
#sortedcontainers >= 2.0, < 3.0']

distutils_enable_tests pytest
