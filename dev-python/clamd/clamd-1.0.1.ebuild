# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Clamd is a python interface to Clamd (Clamav daemon)"
HOMEPAGE="https://github.com/graingert/python-clamd"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.zip"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	app-antivirus/clamav
	app-antivirus/clamav-unofficial-sigs
	dev-python/d2to1
	dev-python/six
	"
DEPEND="
	${RDEPEND}
	test? ( dev-python/pytest )
	"

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	py.test -v || die "Tests fail with ${EPYTHON}"
}
