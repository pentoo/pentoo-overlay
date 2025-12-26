# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/Pennyw0rth/NetExec"
SRC_URI="https://github.com/Pennyw0rth/NetExec/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

#pyproject.toml, [tool.poetry.dependencies]
RDEPEND="
	dev-python/poetry-dynamic-versioning[${PYTHON_USEDEP}]

	>=dev-python/aardwolf-0.2.8[${PYTHON_USEDEP}]
	>=dev-python/argcomplete-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/asyauth-0.0.20[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.11[${PYTHON_USEDEP}]
	>=dev-python/bloodhound-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/dploot-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/dsinternals-1.2.4[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/lsassy-3.1.11[${PYTHON_USEDEP}]
	>=dev-python/masky-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/minikerberos-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/msldap-0.5.14[${PYTHON_USEDEP}]
	>=dev-python/neo4j-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/paramiko-3.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/pylnk3-0.4.2[${PYTHON_USEDEP}]
	>=dev-python/pypsrp-0.8.1[${PYTHON_USEDEP}]
	>=app-exploits/pypykatz-0.6.8[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	>=dev-python/python-libnmap-0.7.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.27.1[${PYTHON_USEDEP}]
	>=dev-python/rich-13.3.5[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0.4[${PYTHON_USEDEP}]
	>=dev-python/termcolor-2.4.0[${PYTHON_USEDEP}]
	dev-python/terminaltables3[${PYTHON_USEDEP}]
	>=dev-python/xmltodict-0.13.0[${PYTHON_USEDEP}]
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/oscrypto[${PYTHON_USEDEP}]
	dev-python/pynfsclient[${PYTHON_USEDEP}]

	>=dev-util/ruff-0.0.292
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#src_prepare() {
#	sed -i -e 's#, "poetry-dynamic-versioning>=1.0.0,<2.0.0"##' pyproject.toml || die
#	sed -i -e 's#poetry_dynamic_versioning.backend#poetry.core.masonry.api#' pyproject.toml || die
#	#sed -i -e '/impacket/d' -e '/pynfsclient/d' pyproject.toml || die
#	default
#}

python_prepare_all() {
	sed -i -e 's#, "poetry-dynamic-versioning>=1.0.0,<2.0.0"##' pyproject.toml || die
	sed -i -e 's#poetry_dynamic_versioning.backend#poetry.core.masonry.api#' pyproject.toml || die
	sed -i -e "s#version = \"0.0.0\"#version = \"${PV}\"#" pyproject.toml || die

	#sed -i -e '/impacket/d' -e '/pynfsclient/d' pyproject.toml || die

	#use pycryptodome instead of pycryptodomex
	#the only thing different appears to be the namespace and gentoo is removing pycryptodomex
	sed -i -e 's#Cryptodome#Crypto#' $(grep -r --color=never 'Cryptodome' | awk -F':' '{print $1}') || die
	distutils-r1_python_prepare_all
}

