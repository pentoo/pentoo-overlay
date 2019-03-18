# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="WSGI (PEP 333) Reference Library"
HOMEPAGE="https://pypi.org/project/wsgiref/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
