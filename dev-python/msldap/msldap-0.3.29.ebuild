# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python library to play with MS LDAP"
HOMEPAGE="https://github.com/skelsec/msldap"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

#'winsspi;platform_system=="Windows"',
# the last two (aiocmd and asciitree) are "Prerequisites"
RDEPEND="dev-python/asn1crypto[${PYTHON_USEDEP}]
	>=dev-python/winsspi-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/minikerberos-0.2.11[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/winacl-0.1.1[${PYTHON_USEDEP}]
	>=dev-python/prompt_toolkit-3.0.2[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]

	dev-python/aiocmd[${PYTHON_USEDEP}]
	dev-python/asciitree[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
