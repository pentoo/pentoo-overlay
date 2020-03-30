# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{3,6} )

inherit distutils-r1

MY_PN=${PN/-/_}

DESCRIPTION="Typing Extensions – Backported and Experimental Type Hints for Python"
HOMEPAGE="https://docs.python.org/3/library/typing.html https://pypi.org/project/typing-extensions/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 arm ~arm64 x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

python_test() {
	cd "${S}"/src_py3 || die
	"${EPYTHON}" test_typing_extensions.py -v || die "tests failed under ${EPYTHON}"
}
