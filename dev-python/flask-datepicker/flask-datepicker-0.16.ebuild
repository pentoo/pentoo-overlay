# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="A Flask extension for Jquery-ui javascript date picker"
HOMEPAGE="https://github.com/mrf345/flask_datepicker/"
SRC_URI="https://github.com/mrf345/flask_datepicker/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

S=${WORKDIR}/${P/-/_}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-bootstrap[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	# don't do cover during the tests
	use test && sed -i -e "s/ --cov.*$//" setup.cfg
	eapply_user
}
