EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

MY_PN="smpp.twisted"
MY_COMMIT="c9b266f54e44e7aff964b64cfb05ca1ecbcd7710"
DESCRIPTION="SMPP 3.4 client built on Twisted"
HOMEPAGE="
	https://github.com/jookies/smpp.twisted
	https://pypi.org/project/smpp.twisted3/
"
# Direct download due to smsc_simulator.py absense in PyPi archive causing test failure
SRC_URI="https://github.com/jookies/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/twisted[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/smpp.twisted3-0.8-drop-pkgutil-namespace.patch"
)

DOCS=( README.md )

distutils_enable_tests unittest
