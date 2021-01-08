# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

# exact version of ruamel.yaml because of unstable API
RDEPEND=">=dev-python/attrs-19.3.0[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.3[${PYTHON_USEDEP}]
	~dev-python/junit-xml-1.9[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	=dev-python/ruamel-yaml-0.16*[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.46.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.4[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]

	dev-python/wheel[${PYTHON_USEDEP}]
	dev-util/semgrep-core-bin"
#quick workaround: dev-util/semgrep-core-bin
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i "s|ruamel.yaml==|ruamel.yaml>=|g" setup.py
	rm -r tests
	eapply_user
}

python_install() {
	export PRECOMPILED_LOCATION="/usr/bin/semgrep-core"
	distutils-r1_python_install
}
