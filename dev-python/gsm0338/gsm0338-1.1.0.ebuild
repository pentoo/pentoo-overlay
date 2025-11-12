EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Codec for 3GPP TS 23.038 / ETSI GSM 03.38"
HOMEPAGE="
	https://github.com/dsch/gsm0338
	https://pypi.org/project/gsm0338/
"
# pypi tarball are missing test data
SRC_URI="https://github.com/dsch/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

python_test() {
	epytest tests
}
