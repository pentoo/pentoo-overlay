EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

MY_PN="asn1tools"
MY_COMMIT="44277cdb34959196f317b6a02af20a4a1c3c4e2d"
DESCRIPTION="ASN.1 parsing, encoding and decoding - OSMOCOM patched"
HOMEPAGE="https://github.com/osmocom/asn1tools"
SRC_URI="https://github.com/osmocom/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!dev-python/asn1tools
	>=dev-python/pyparsing-3.0.6[${PYTHON_USEDEP}]
	dev-python/bitstruct[${PYTHON_USEDEP}]
	dev-python/diskcache[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/asn1tools-0.166.0-remove-c-rust-tests.patch"
	"${FILESDIR}/asn1tools-0.166.0-disable-pyparsing-sensitive-tests.patch"
	"${FILESDIR}/asn1tools-0.166.0-disable-shell-cmd-tests-due-to-PromptSession-issues.patch"
)

distutils_enable_tests unittest

python_test() {
	local tests=$(find tests -name "test_*.py")
	"${EPYTHON}" -m unittest -v $tests || die -n "Tests failed with ${EPYTHON}"
}
