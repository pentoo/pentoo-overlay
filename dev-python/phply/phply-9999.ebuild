# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1
[[ ${PV} == 9999* ]] && inherit git-2

DESCRIPTION="Parser for PHP written using PLY"
HOMEPAGE="https://github.com/ramen/phply"
LICENSE="BSD"
SLOT="0"
IUSE="test"

EGIT_REPO_URI="https://github.com/andresriancho/phply.git"
if ! [[ ${PV} == 9999* ]]; then
	KEYWORDS="~amd64"
	EGIT_COMMIT="435f523918145437e22d43712abcb4956e106178"
else
	KEYWORDS=""
fi

DEPEND="
	dev-python/ply
	test? ( dev-python/nose )
	"
RDEPEND="${DEPEND}"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# remove package of tests to avoid installing it
	rm "${S}/tests/__init__.py"
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	nosetests || die "Tests fail with ${EPYTHON}"
}
