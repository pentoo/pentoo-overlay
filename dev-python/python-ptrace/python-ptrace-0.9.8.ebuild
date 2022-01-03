# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A Python binding of ptrace library"
HOMEPAGE="https://github.com/vstinner/python-ptrace"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="GPL-2"
SLOT=0

RDEPEND="${PYTHON_DEPS}
	dev-python/six[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

src_test() {
	./runtests.py --tests tests/ || die
}
