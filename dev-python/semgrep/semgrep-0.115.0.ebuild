# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/attrs-21.3[${PYTHON_USEDEP}]
	>=dev-python/boltons-21.0[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1[${PYTHON_USEDEP}]
	>=dev-python/click-option-group-0.5[${PYTHON_USEDEP}]
	>=dev-python/glom-22.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.16.0[${PYTHON_USEDEP}] <dev-python/ruamel-yaml-0.19.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.46[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.6[${PYTHON_USEDEP}]
	>=dev-python/wcmatch-8.3[${PYTHON_USEDEP}]
	>=dev-python/peewee-3.14[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.2[${PYTHON_USEDEP}]
	>=dev-python/python-lsp-jsonrpc-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]

	dev-util/semgrep-core-bin"
DEPEND="${RDEPEND}"

src_prepare(){
	rm -r tests
	sed -i -e 's|~=|>=|g' setup.py || die
	eapply_user
}

python_compile() {
	export SEMGREP_SKIP_BIN=true
	distutils-r1_python_compile
}
