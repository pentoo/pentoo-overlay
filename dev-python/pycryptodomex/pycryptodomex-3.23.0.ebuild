EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Self-contained package of low-level cryptographic primitives"
HOMEPAGE="
	https://www.pycryptodome.org
	https://pypi.org/project/pycryptodomex/
"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.rst )

python_test() {
	"${EPYTHON}" setup.py test || die -n "Tests failed with ${EPYTHON}"
}
