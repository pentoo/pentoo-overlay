# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="The next generation HTTP client."
HOMEPAGE="https://github.com/encode/httpx https://pypi.org/project/httpx/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/rfc3986-1.3[idna,${PYTHON_USEDEP}]
	=dev-python/httpcore-0.12*[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
