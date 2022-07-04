# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="ASN.1 parsing, encoding and decoding"
HOMEPAGE="
	https://github.com/eerimoq/asn1tools
	https://pypi.org/project/asn1tools
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND=">=dev-python/pyparsing-3.0.6[${PYTHON_USEDEP}]
	dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/bitstruct[${PYTHON_USEDEP}]
	dev-python/diskcache[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#test?
#	dev-python/bitstruct[${PYTHON_USEDEP}]
#	dev-python/diskcache[${PYTHON_USEDEP}]
#	dev-python/unittest-or-fail

distutils_enable_tests unittest
