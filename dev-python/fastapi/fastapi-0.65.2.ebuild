# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{9..10} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="FastAPI framework, high performance, easy to learn, fast to code, ready for production"
HOMEPAGE="https://fastapi.tiangolo.com/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="
	>=dev-python/starlette-0.14.2[${PYTHON_USEDEP}]
	<dev-python/starlette-0.18.0[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
"
