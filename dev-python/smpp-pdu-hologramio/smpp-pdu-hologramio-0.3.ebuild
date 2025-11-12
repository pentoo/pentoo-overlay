EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

MY_PN="smpp.pdu"
MY_COMMIT="20acc840ded958898eeb35ae9a18df9b29bdaaac"
DESCRIPTION="PDUs parsing in SMPP protocol - hologram-io patched"
HOMEPAGE="
	https://github.com/mozes/smpp.pdu
	https://github.com/hologram-io/smpp.pdu
"
SRC_URI="https://github.com/hologram-io/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/smpp.pdu-0.3-drop-pkgutil-namespace.patch"
)

distutils_enable_tests unittest

python_test() {
	eunittest -s tests
}
