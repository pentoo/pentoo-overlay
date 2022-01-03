# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Whois querying and parsing of domain registration information"
HOMEPAGE="https://github.com/richardpenman/pywhois"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}
	dev-python/future[${PYTHON_USEDEP}]
	test? (
		dev-python/simplejson[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

RDEPEND=""

distutils_enable_tests unittest
