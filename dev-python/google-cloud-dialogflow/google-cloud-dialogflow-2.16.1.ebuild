# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
#DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Client library for the Dialogflow API"
HOMEPAGE="https://github.com/googleapis/python-dialogflow"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
#IUSE="test"
IUSE=""

RDEPEND="
	dev-python/google-api-core[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]

"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	rm -r tests
	eapply_user
}
