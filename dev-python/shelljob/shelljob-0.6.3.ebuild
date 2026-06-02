# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Run multiple subprocesses asynchronous/in parallel with streamed output"
HOMEPAGE="https://pypi.org/project/shelljob/"

SRC_URI="https://github.com/mortoray/shelljob/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# download file
	'test/test_namedtempfile.py::test_example'
)
distutils_enable_tests pytest

python_test() {
	sed -i -e 's/UTF/test\/UTF/' test/test_group.py || die "Sed failed to patch test."
	sed -i -e 's/UTF/test\/UTF/' test/test_proc.py || die "Sed failed to patch test."
	sed -i -e 's/happy\.txt/test\/happy\.txt/' test/test_proc.py || die "Sed failed to patch test."

	epytest
}
