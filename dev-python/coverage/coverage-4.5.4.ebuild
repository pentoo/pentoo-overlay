# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} pypy pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Code coverage measurement for Python"
HOMEPAGE="https://coverage.readthedocs.io/en/latest/ https://pypi.org/project/coverage/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${PYTHON_DEPS}"
#	test? (
#		dev-python/pytest[${PYTHON_USEDEP}]
#		dev-python/PyContracts[${PYTHON_USEDEP}]
#		dev-python/mock[${PYTHON_USEDEP}]
#		dev-python/nose[${PYTHON_USEDEP}]
#	)"

python_compile() {
	if [[ ${EPYTHON} == python2.7 ]]; then
		local CFLAGS="${CFLAGS} -fno-strict-aliasing"
		export CFLAGS
	fi

	distutils-r1_python_compile
}

#python_test() {
#	cd "${BUILD_DIR}"/lib || die
#	[[ "${PYTHON}" =~ pypy ]] && export COVERAGE_NO_EXTENSION=no
#	${PYTHON} "${S}"/igor.py test_with_tracer py || die
#	${PYTHON} "${S}"/igor.py test_with_tracer c || die
#}
