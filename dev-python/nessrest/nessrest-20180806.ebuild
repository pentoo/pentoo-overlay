# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A high-level Web Crawling and Web Scraping framework"
HOMEPAGE="https://scrapy.org/"

#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
COMMIT_HASH="af28834d6253db0d00e3ab46ab259dd5bc903063"
SRC_URI="https://github.com/tenable/nessrest/archive/${COMMIT_HASH}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${COMMIT_HASH}"
