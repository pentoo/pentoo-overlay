# Copyright 1999-2017 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Use Requests with Gevent to make asyncronous HTTP Requests easily"
HOMEPAGE="https://github.com/kennethreitz/grequests"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/nose[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

RESTRICT="test"
