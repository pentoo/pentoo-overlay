# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Asynchronous framework for Telegram Bot API"
HOMEPAGE="https://github.com/aiogram/aiogram"

LICENSE="MIT"
SLOT="0"
# https://github.com/aiogram/aiogram/issues/1427
#KEYWORDS="~amd64 ~x86"
IUSE="docs i18n fast proxy redis"
RESTRICT="test"

RDEPEND="
	>=dev-python/magic-filter-1.0.12[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.4.1[${PYTHON_USEDEP}] <dev-python/pydantic-2.6
	>=dev-python/aiofiles-23.2.1[${PYTHON_USEDEP}]
	>=dev-python/certifi-2023.7.22[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.7.0[${PYTHON_USEDEP}]

	fast? (
		>=dev-python/uvloop-0.17.0[${PYTHON_USEDEP}]
		>=dev-python/aiodns-3.0.0[${PYTHON_USEDEP}]
	)
	i18n? ( >=dev-python/Babel-2.13.0[${PYTHON_USEDEP}] )
	proxy? ( >=dev-python/aiohttp-socks-0.8.3[${PYTHON_USEDEP}] )
	redis? ( >=dev-python/redis-5.0.1[${PYTHON_USEDEP}]
		dev-python/hiredis[${PYTHON_USEDEP}] )
	docs? (
		dev-python/sphinx
		dev-python/furo
		dev-python/sphinx-prompt
		dev-python/towncrier
		dev-python/pymdown-extensions
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
