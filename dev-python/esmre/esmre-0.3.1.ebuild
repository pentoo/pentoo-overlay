# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Regular expression accelerator"
HOMEPAGE="https://code.google.com/p/esmre/"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	${EPYTHON} "${S}"/test/test_esm.py && ${EPYTHON} "${S}"/test/test_esmre.py ||
		die "Tests fail with ${EPYTHON}"
}
