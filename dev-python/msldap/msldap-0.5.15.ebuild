# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Python library to play with MS LDAP"
HOMEPAGE="https://github.com/skelsec/msldap"
SRC_URI="https://github.com/skelsec/msldap/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="examples"

#'winsspi;platform_system=="Windows"',
# the last two (aiocmd and asciitree) are "Prerequisites"
# extra: ./msldap/external/*
RDEPEND="
	>=dev-python/asn1crypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/asyauth-0.0.18[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.11[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/winacl-0.1.9[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]

	dev-python/aiocmd[${PYTHON_USEDEP}]
	dev-python/asciitree[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_sphinx 'docs/source'

python_install_all() {
	if use examples; then
		docinto examples
		dodoc -r examples/.
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}
