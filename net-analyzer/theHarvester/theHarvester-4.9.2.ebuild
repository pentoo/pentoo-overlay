# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="https://github.com/laramies/theHarvester"
SRC_URI="https://github.com/laramies/theHarvester/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# requirements/base.txt
RDEPEND="${PYTHON_DEPS}
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiomultiprocess[${PYTHON_USEDEP}]
	dev-python/aiosqlite[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/censys[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/dnspython-2.1.0[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.6.4[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/playwright-bin[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/retrying[${PYTHON_USEDEP}]
	>=net-analyzer/shodan-1.28.0[${PYTHON_USEDEP}]
	dev-python/slowapi[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]

	dev-python/uvloop[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	"

DEPEND="${RDEPEND}"
	# test? (
	# 	dev-python/flake8[${PYTHON_USEDEP}]
	# 	dev-python/mypy[${PYTHON_USEDEP}]
	# )"

# distutils_enable_tests pytest

src_prepare() {
	# network required for tests
	rm -r tests || die
	default
}
