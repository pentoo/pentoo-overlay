# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="A high-level Web Crawling and Web Scraping framework"
HOMEPAGE="https://scrapy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT=0
#dev-python/tldextract is not stable on x86
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-python/twisted-17.9.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.0[${PYTHON_USEDEP}]
	>=dev-python/cssselect-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/itemloaders-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/parsel-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.2.0[${PYTHON_USEDEP}]
	>=dev-python/queuelib-1.4.2[${PYTHON_USEDEP}]
	>=dev-python/service_identity-16.0.0[${PYTHON_USEDEP}]
	>=dev-python/w3lib-1.17.0[${PYTHON_USEDEP}]
	>=dev-python/zope-interface-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/Protego-0.1.15[${PYTHON_USEDEP}]
	>=dev-python/itemadapter-0.1.0[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
	
	=dev-python/pydispatcher-2.0*[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#FIXME:
#cpython:
#    'lxml>=3.5.0',
#    'PyDispatcher>=2.0.5',

#PyPy
#  'lxml>=4.0.0',
#  'PyPyDispatcher>=2.1.0',

# Also see:
# https://bugs.gentoo.org/684734
