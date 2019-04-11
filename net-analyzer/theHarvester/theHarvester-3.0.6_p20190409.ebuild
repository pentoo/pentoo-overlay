# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

HASH_COMMIT="9f7811d3784a43434cb6ef71107d9ef4701432e6"

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/censys[${PYTHON_USEDEP}]
	dev-python/plotly[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	dev-python/shodan[${PYTHON_USEDEP}]
	dev-python/texttable[${PYTHON_USEDEP}]
	net-analyzer/wfuzz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
#	python_fix_shebang .
	rm -r tests
	eapply_user
}
