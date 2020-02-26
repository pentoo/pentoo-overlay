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

pkg_postinst() {
	einfo "\nBeware when first running the module, it updates its TLD list with a live HTTP request."
	einfo "This updated TLD set is cached indefinitely in /path/to/tldextract/.tld_set.\n"
	einfo "To avoid this fetch or control the cache's location, use your own extract"
	einfo "callable by setting 'TLDEXTRACT_CACHE' environment variable or by setting the cache_file path"
	einfo "in TLDExtract initialization.\n"
	einfo "If you want to stay fresh with the TLD definitions--though they"
	einfo "don't change often--delete the cache file occasionally, or run:"
	einfo "    ~$ env TLDEXTRACT_CACHE=\"~/tldextract.cache\" tldextract --update\n"
}
