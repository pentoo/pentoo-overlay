# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python implementation of SAML Version 2 to be used in a WSGI environment"
HOMEPAGE="https://github.com/rohe/pysaml2"
SRC_URI="https://github.com/IdentityPython/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	>=dev-python/cryptography-3.1[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/xmlschema-2.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pyasn1[${PYTHON_USEDEP}]
		>=dev-python/pymongo-3[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"
#		dev-python/toml[${PYTHON_USEDEP}]

distutils_enable_tests pytest

python_prepare_all() {
	# No module named 'pymongo.mongo_replica_set_client' because pymongo should be <4 but we only have >=4
	rm tests/test_{75_mongodb,76_metadata_in_mdb}.py || die

	distutils-r1_python_prepare_all
}
