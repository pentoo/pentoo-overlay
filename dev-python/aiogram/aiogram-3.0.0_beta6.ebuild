# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_beta/-beta.}"
MY_P="${PN}-${MY_PV}"

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Asynchronous framework for Telegram Bot API"
HOMEPAGE="https://github.com/aiogram/aiogram"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/aiogram/aiogram/archive/refs/tags/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="docs i18n fast proxy redis"
RESTRICT="test"

RDEPEND="
	>=dev-python/magic-filter-1.0.9[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.8.3[${PYTHON_USEDEP}] <dev-python/aiohttp-3.9.0
	>=dev-python/pydantic-1.10.2
	>=dev-python/aiofiles-22.1.0
	fast? (
		>=dev-python/uvloop-0.16.0[${PYTHON_USEDEP}]
		>=dev-python/ujson-1.35[${PYTHON_USEDEP}]
	)
	i18n? ( >=dev-python/Babel-2.9.1[${PYTHON_USEDEP}] <dev-python/Babel-2.11.0 )
	proxy? ( >=dev-python/aiohttp-socks-0.5.3[${PYTHON_USEDEP}] )
	redis? ( dev-python/redis-py )
	>=dev-python/certifi-2022.9.24
	docs? (
		dev-python/Sphinx
		dev-python/sphinx-intl
		dev-python/sphinx-autobuild
		dev-python/sphinx-copybutton
		dev-python/furo
		dev-python/sphinx-prompt
		dev-python/Sphinx-Substitution-Extensions
		dev-python/towncrier
		dev-python/pymdown-extensions
		dev-python/markdown-include
		dev-python/pygments
	)"
DEPEND="${RDEPEND}"

#BDEPEND="
#	test? (
#		dev-python/redis-py[${PYTHON_USEDEP}]
#		dev-python/magic-filter[${PYTHON_USEDEP}]
#		dev-python/aiofiles[${PYTHON_USEDEP}]
#		dev-python/aiohttp[${PYTHON_USEDEP}]
#	)
#"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#    from aresponses import ResponsesMockServer
#   ModuleNotFoundError: No module named 'aresponses'
#distutils_enable_tests pytest

S="${WORKDIR}/${MY_P}"
