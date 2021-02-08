# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

HOMEPAGE="https://github.com/darkoperator/dnsrecon"
DESCRIPTION="DNS Enumeration Script"

SRC_URI="https://github.com/darkoperator/dnsrecon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/dnsrecon-0.10.0_namelist.patch" )

python_install() {
	distutils-r1_python_install
	python_foreach_impl python_newscript dnsrecon.py dnsrecon
	python_foreach_impl python_newscript tools/parser.py dnsrecon-parser

	dodoc -r msf_plugin/ *.md
}
