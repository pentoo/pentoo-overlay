# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="DPAPI looting remotely in Python"
HOMEPAGE="https://github.com/zblurx/dploot"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	>=dev-python/impacket-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-40.0.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.4.8[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.9.3[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

python_prepare_all() {
	# do not install data files under Gentoo
	sed -i -e "s|Darwin|Linux|" setup.py || die
	#use pycryptodome instead of pycryptodomex
	#the only thing different appears to be the namespace and gentoo is removing pycryptodomex
	sed -i -e 's#Cryptodome#Crypto#' $(grep -r --color=never 'Cryptodome' | awk -F':' '{print $1}') || die
	distutils-r1_python_prepare_all
}
