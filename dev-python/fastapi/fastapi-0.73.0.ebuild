# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{9..10} )
#may be not stricly required
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

#starlette is locked in the pyproject.toml
RDEPEND="
	~dev-python/starlette-0.17.1[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
"
#FIXME: add missing deps
#BDEPEND="test? (
#	dev-python/pytest[${PYTHON_USEDEP}]
#	dev-python/pytest-cov[${PYTHON_USEDEP}]
#	dev-python/mypy[${PYTHON_USEDEP}]
#	dev-python/flake8[${PYTHON_USEDEP}]
#	dev-python/black[${PYTHON_USEDEP}]
#	dev-python/isort[${PYTHON_USEDEP}]
#	dev-python/requests[${PYTHON_USEDEP}]
#	dev-python/httpx[${PYTHON_USEDEP}]
#	dev-python/email_validator[${PYTHON_USEDEP}]
#	dev-python/sqlalchemy[${PYTHON_USEDEP}]
#	dev-python/peewee[${PYTHON_USEDEP}]
#	dev-python/databases[sqlite]
#	dev-python/orjson[${PYTHON_USEDEP}]
#	dev-python/ujson[${PYTHON_USEDEP}]
#	dev-python/python-multipart[${PYTHON_USEDEP}]
#	dev-python/flask[${PYTHON_USEDEP}]
#	dev-python/anyio[trio]
#	dev-python/types-ujson[${PYTHON_USEDEP}]
#	dev-python/types-orjson[${PYTHON_USEDEP}]
#)"

#distutils_enable_tests pytest
