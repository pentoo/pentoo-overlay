# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Library to populate items using XPath and CSS with a convenient API"
HOMEPAGE="https://scrapy.org/"
SRC_URI="https://github.com/scrapy/itemloaders/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="test"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/itemadapter[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/parsel[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
"

#distutils_enable_tests pytest
