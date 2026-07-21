# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Easy, clean, reliable Python 2/3 compatibility"
HOMEPAGE="
	https://python-future.org/
	https://github.com/PythonCharmers/python-future/
	https://pypi.org/project/future/
"
SRC_URI+=" https://dev.gentoo.org/~sam/distfiles/${CATEGORY}/${PN}/${PN}-0.18.3-tests.patch.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~mips ppc ppc64 ~riscv ~s390 sparc x86"

# The official support is until python =< 3.12
# However tests run "import imp" which was removed in Python 3.12
# ModuleNotFoundError: No module named 'imp'
RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-0.18.2-py3.10.patch
)
