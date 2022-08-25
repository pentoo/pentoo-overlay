# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Asynchronous framework for Telegram Bot API"
HOMEPAGE="https://github.com/aiogram/aiogram"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="proxy fast"

RDEPEND="
	>=dev-python/aiohttp-3.8.0[${PYTHON_USEDEP}] <dev-python/aiohttp-3.9.0
	>=dev-python/Babel-2.9.1[${PYTHON_USEDEP}] <dev-python/Babel-2.11.0
	>=dev-python/certifi-2021.10.8[${PYTHON_USEDEP}]
	
	proxy? ( >=dev-python/aiohttp-socks-0.5.3[${PYTHON_USEDEP}] )
	fast? (
		>=dev-python/uvloop-0.16.0[${PYTHON_USEDEP}]
		>=dev-python/ujson-1.35[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
