EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="TLV (tag length value) data parser"
HOMEPAGE="
	https://github.com/timgabets/pytlv
	https://pypi.org/project/pytlv/
"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )

python_test() {
	eunittest -s pytlv
}
