# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Django SAML2 Service Provider based on pySAML2"
HOMEPAGE="https://github.com/IdentityPython/djangosaml2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=dev-python/defusedxml-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/django-2.2[${PYTHON_USEDEP}]
	>=dev-python/pysaml2-6.5.1[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
