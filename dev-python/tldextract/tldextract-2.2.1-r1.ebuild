# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Accurately separate the TLD from the registered domain and subdomains"
HOMEPAGE="https://github.com/john-kurkowski/tldextract"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-file[${PYTHON_USEDEP}]"

# https://github.com/john-kurkowski/tldextract#note-about-caching
PATCHES=( "${FILESDIR}/${P}_change_tldextract_cache_defaults.patch" )
