# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Clamd is a python interface to Clamd (Clamav daemon)"
HOMEPAGE="https://github.com/graingert/python-clamd"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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
