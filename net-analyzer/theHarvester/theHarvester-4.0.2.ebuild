# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#dev-python/plotly not stable, no x86 for orjson
KEYWORDS="~amd64 ~arm64"
# IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# RESTRICT="!test? ( test )"

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
	dev-python/orjson-bin
	dev-python/pyppeteer[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/retrying[${PYTHON_USEDEP}]
	>=dev-python/shodan-1.25.0[${PYTHON_USEDEP}]
	dev-python/slowapi[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-util/unicorn[${PYTHON_USEDEP}]
	dev-python/uvloop[${PYTHON_USEDEP}]
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
