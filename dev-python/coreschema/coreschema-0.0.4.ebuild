# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Core Schema"
HOMEPAGE="https://github.com/core-api/python-coreschema"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
