# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python based ingestor for BloodHound"
HOMEPAGE="https://github.com/dirkjanm/bloodhound.py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

# FIXME: get rid of future, see:
# https://github.com/dirkjanm/BloodHound.py/issues/158

RDEPEND="
	dev-python/dnspython[${PYTHON_USEDEP}]
	>=dev-python/impacket-0.9.17[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.4[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
"
#	www-apps/BloodHound

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
