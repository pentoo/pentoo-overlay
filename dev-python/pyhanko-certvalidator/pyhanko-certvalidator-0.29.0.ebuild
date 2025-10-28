# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit pypi distutils-r1

DESCRIPTION="Python library for validating X.509 certificates and paths"
HOMEPAGE="https://pypi.org/project/pyhanko-certvalidator/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

#optional: async-http = ["aiohttp>=3.9,<3.13"]
RDEPEND="
	>=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]
	>=dev-python/oscrypto-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41.0.5[${PYTHON_USEDEP}]
	>=dev-python/uritools-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
