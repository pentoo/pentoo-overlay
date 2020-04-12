# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

HOMEPAGE="https://github.com/darkoperator/dnsrecon"
DESCRIPTION="DNS Enumeration Script"

HASH_COMMIT="834ebe6c11f70e42a779b48d2cb67c9e21812ea5"
SRC_URI="https://github.com/darkoperator/dnsrecon/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# For testing
#KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-pentoo.patch" )

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

python_install() {
	distutils-r1_python_install
	python_foreach_impl python_newscript dnsrecon.py dnsrecon
	python_foreach_impl python_newscript tools/parser.py dnsrecon-parser

	dodoc -r msf_plugin/ *.md
}
