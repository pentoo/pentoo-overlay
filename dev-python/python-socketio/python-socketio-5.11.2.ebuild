# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of the Socket.IO realtime server."
HOMEPAGE="
	https://python-socketio.readthedocs.org/
	https://github.com/miguelgrinberg/python-socketio/
	https://pypi.org/project/python-socketio"

LICENSE="MIT"
SLOT="0"
#FIXME: no stable version for dev-python/python-engineio yet, but we don't care
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="client asyncio-client"

RDEPEND="dev-python/bidict[${PYTHON_USEDEP}]
	>=dev-python/python-engineio-4.8.0[${PYTHON_USEDEP}]
	client? ( dev-python/requests[${PYTHON_USEDEP}]
		dev-python/websocket-client[${PYTHON_USEDEP}] )
	asyncio-client? ( dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# pypi tarball does not contain tests
RESTRICT="test"
