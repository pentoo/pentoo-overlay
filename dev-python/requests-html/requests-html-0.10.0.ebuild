# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="HTML Parsing for Humans"
HOMEPAGE="https://github.com/psf/requests-html https://pypi.org/project/requests-html/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
# KEYWORDS="~amd64 ~x86"  # Requires dev-python/pyppeteer which misses a dep
IUSE="test"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyquery[${PYTHON_USEDEP}]
	dev-python/fake-useragent[${PYTHON_USEDEP}]
	dev-python/parse[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
	>=dev-python/pyppeteer-0.0.14[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
