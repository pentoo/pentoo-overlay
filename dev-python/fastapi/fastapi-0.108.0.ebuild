# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )
#may be not stricly required
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 pypi

DESCRIPTION="High performance framework, easy to learn, fast to code, ready for production"
HOMEPAGE="https://fastapi.tiangolo.com/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#starlette is not stable
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="all"

RESTRICT="test"

# FIXME: missing deps:
#	>=dev-python/pydantic-settings-2.0.0[${PYTHON_USEDEP}]
#	>=dev-python/pydantic-extra-types-2.0.0[${PYTHON_USEDEP}]
RDEPEND="
	>=dev-python/starlette-0.27.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/anyio-3.7.1[${PYTHON_USEDEP}]
all? (
	>=dev-python/httpx-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.11.2[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.5[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
	>=dev-python/ujson-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.2.1[${PYTHON_USEDEP}]
	>=dev-python/email-validator-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.12.0[${PYTHON_USEDEP}]
)"

#FIXME: add missing deps
#BDEPEND="test? (
#)"

#distutils_enable_tests pytest

#src_prepare(){
#	sed -i -e 's|starlette==0.19.1|starlette>=0.19.1|g' pyproject.toml || die
#	eapply_user
#}
