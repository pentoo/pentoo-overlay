# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Whois querying and parsing of domain registration information"
HOMEPAGE="https://github.com/richardpenman/pywhois"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}
	test? (
		dev-python/simplejson[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

RDEPEND="${DEPEND}"

distutils_enable_tests unittest
