# Copyright2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to play with MS LDAP"
HOMEPAGE="https://github.com/skelsec/msldap"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

#'winsspi;platform_system=="Windows"',
# the last two (aiocmd and asciitree) are "Prerequisites"
# extra: ./msldap/external/*
RDEPEND="
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/asyauth-0.0.18[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.11[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/winacl-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.2[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]

	dev-python/aiocmd[${PYTHON_USEDEP}]
	dev-python/asciitree[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
