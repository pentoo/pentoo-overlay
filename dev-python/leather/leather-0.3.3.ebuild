# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Python charting for 80% of humans"
HOMEPAGE="https://leather.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/six[${PYTHON_USEDEP}]"
