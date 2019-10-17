# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-python/aiodns-2.0.0[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/dnspython-1.16.0[${PYTHON_USEDEP}]
	>=dev-python/grequests-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.19[${PYTHON_USEDEP}]
	>=dev-python/plotly-1.9.6[${PYTHON_USEDEP}]
	>=dev-python/pytest-3.10.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
	>=dev-python/shodan-1.17.0[${PYTHON_USEDEP}]
	>=dev-python/texttable-1.6.2[${PYTHON_USEDEP}]
	>=dev-python/retrying-1.3.3[${PYTHON_USEDEP}]"

#	net-analyzer/wfuzz[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] 
	>=dev-python/flake8-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/mypy-0.701[${PYTHON_USEDEP}]
	)"

src_prepare() {
	rm -r tests
	eapply_user
}
