# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# CAUTION: The project is named pytsk, but the versions and release files are
# called pytsk3-yyyymmdd (see SRC_URI and S below).

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python bindings for The Sleuth Kit (libtsk)"
HOMEPAGE="https://github.com/py4n6/pytsk/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}3/${PN}3-${PV}.tar.gz"
S="${WORKDIR}/${PN}3-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	>=app-forensics/sleuthkit-4.11
	>=dev-python/pip-7.0[${PYTHON_USEDEP}]
	sys-libs/talloc[python]
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

python_test() {
	"${EPYTHON}" run_tests.py -v || die
}
