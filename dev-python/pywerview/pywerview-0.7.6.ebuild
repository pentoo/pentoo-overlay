# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="A Python port of PowerSploit's PowerView"
HOMEPAGE="https://github.com/the-useless-one/pywerview"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/impacket-0.13.0[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	>=dev-python/ldap3-2.8.1[${PYTHON_USEDEP}]
	dev-python/gssapi[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
"
