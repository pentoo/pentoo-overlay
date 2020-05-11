# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7,8} pypy{,3} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="A self-contained cryptographic library for Python"
HOMEPAGE="https://www.pycryptodome.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2 Unlicense"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-libs/gmp:0
	virtual/python-cffi[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

#Gentoo pycryptodome patches
PATCHES=(
	"${FILESDIR}/pycryptodome-3.9.4-parallel-make.patch"
	# https://github.com/Legrandin/pycryptodome/pull/351
#	"${FILESDIR}/pycryptodome-3.9.4-tests.patch"
)

python_prepare_all() {
	# parallel make fixes
	#  Multiple targets were compiling the same file, setuptools doesn't
	#  understand this and you get race conditions where a file gets
	#  overwritten while it's linking. This makes the files look like separate
	#  files so this race won't happen
	ln src/blowfish.c src/blowfish_eks.c || die
	ln src/mont.c src/mont_math.c || die

	distutils-r1_python_prepare_all
}

python_test() {
	esetup.py test -vv
}
