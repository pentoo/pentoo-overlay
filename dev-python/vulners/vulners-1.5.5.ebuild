# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python API wrapper for the Vulners Database"
HOMEPAGE="https://github.com/vulnersCom/api"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="amd64 ~arm ~x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
