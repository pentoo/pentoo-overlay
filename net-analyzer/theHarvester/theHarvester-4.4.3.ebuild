# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# RESTRICT="!test? ( test )"

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
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/pyppeteer[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/retrying[${PYTHON_USEDEP}]
	>=dev-python/shodan-1.28.0[${PYTHON_USEDEP}]
	dev-python/slowapi[${PYTHON_USEDEP}]
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

# hack: https://github.com/laramies/theHarvester/issues/1430
# hack needs to symlink "new" location to old location to avoid violating PMS
# * Package 'net-analyzer/theHarvester-4.3.0' has one or more collisions
# * between symlinks and directories, which is explicitly forbidden by PMS
# * section 13.4 (see bug #326685)

python_install_all() {
	dodir /etc
	mv "${D}$(python_get_sitedir)/etc/theHarvester" "${ED}/etc" || die
	rm -r "${D}$(python_get_sitedir)/etc" || die
	dosym /etc/theHarvester "$(python_get_sitedir)/etc/theHarvester"
	distutils-r1_python_install_all
}

pkg_preinst() {
	# Fix the broken hack by keeping /etc/theHarvester as a directory not a symlink
	# * Package 'net-analyzer/theHarvester-4.3.0' has one or more collisions
	# * between symlinks and directories, which is explicitly forbidden by PMS
	# * section 13.4 (see bug #326685)
	if [ -L "/etc/theHarvester" ]; then
		rm /etc/theHarvester
	fi
}
