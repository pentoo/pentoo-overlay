# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/attrs-19.3.0[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.3[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.1[${PYTHON_USEDEP}]
	>=dev-python/click-option-group-0.5.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.16.0[${PYTHON_USEDEP}] <dev-python/ruamel-yaml-0.18.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.46.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.4[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/wcmatch-8.3[${PYTHON_USEDEP}]
	>=dev-python/peewee-3.14.4[${PYTHON_USEDEP}]

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
