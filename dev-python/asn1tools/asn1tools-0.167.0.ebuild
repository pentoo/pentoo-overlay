# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="ASN.1 parsing, encoding and decoding"
HOMEPAGE="
	https://github.com/eerimoq/asn1tools
	https://pypi.org/project/asn1tools
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="cache shell test"

RDEPEND=">=dev-python/pyparsing-3.0.6[${PYTHON_USEDEP}]
	dev-python/bitstruct[${PYTHON_USEDEP}]

	shell? ( dev-python/prompt-toolkit[${PYTHON_USEDEP}] )
	cache? ( dev-python/diskcache[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests unittest
