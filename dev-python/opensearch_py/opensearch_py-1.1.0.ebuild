# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Python low-level client for OpenSearch"
HOMEPAGE="
		https://pypi.org/project/opensearch-py
		https://github.com/opensearch-project/opensearch-py
"
MY_PN="opensearch-py"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	>=dev-python/pbr-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-17.1.0[${PYTHON_USEDEP}]
"
DEPEND="
	${PYTHON_DEPS}
	>=dev-python/urllib3-1.21.1[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

# This is a client package; the upstream tests require a local server installation and are
# therefore not included in this ebuild. For tests, we also would require
#	test? (
#		=dev-python/requests-2*
#		dev-python/coverage
#		dev-python/mock
#		dev-python/pyyaml
#		dev-python/pytest
#		dev-python/pytest-cov
#		dev-python/botocore
#	)
