# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Service identity verification for pyOpenSSL."
HOMEPAGE="https://service-identity.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.12[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]"

#idna; extra == 'idna'

RDEPEND="${DEPEND}"
