# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1 git-r3

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/ https://pypi.python.org/pypi/dnspython"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
EGIT_REPO_URI="https://github.com/rthalley/dnspython.git"
EGIT_COMMIT="1bb88cfecacb18fb406466e38a5b9c185cb5373e"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="examples test"

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]
	!dev-python/dnspython:py2
	!dev-python/dnspython:py3"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	app-arch/unzip"

# For testsuite
DISTUTILS_IN_SOURCE_BUILD=1

#https://github.com/rthalley/dnspython/issues/271
#https://bugs.gentoo.org/611590
PATCHES=( "${FILESDIR}/pull290.patch" )

python_test() {
	cd tests || die
	"${PYTHON}" utest.py || die "tests failed under ${EPYTHON}"
	einfo "Testsuite passed under ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
