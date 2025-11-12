EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Python implementation of core osmocom utilities / protocols"
HOMEPAGE="
	https://osmocom.org/projects/pyosmocom/wiki
	https://pypi.org/project/pyosmocom/
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/gsm0338[${PYTHON_USEDEP}]
	>=dev-python/construct-2.9.51[${PYTHON_USEDEP}]
"

DOCS=( README.md )

distutils_enable_tests unittest

python_test() {
	eunittest -s tests
}
