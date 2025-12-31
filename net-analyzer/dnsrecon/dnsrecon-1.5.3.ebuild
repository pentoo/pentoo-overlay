# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="DNS Enumeration Script"
HOMEPAGE="https://github.com/darkoperator/dnsrecon"
SRC_URI="https://github.com/darkoperator/dnsrecon/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/dnspython-2.7.0[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.116.1[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.35.0[${PYTHON_USEDEP}]
	>=dev-python/slowapi-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/stamina-25.1.0[${PYTHON_USEDEP}]
	>=dev-python/ujson-5.11.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_prepare() {
	rm -r tests || die
	default
}

python_install() {
	distutils-r1_python_install
	python_foreach_impl python_newscript tools/parser.py dnsrecon-parser
}
