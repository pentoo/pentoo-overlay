# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A package is a collection of utilities for dealing with IP addresses"
HOMEPAGE="http://github.com/ronaldoussoren/macholib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/altgraph[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_sphinx doc
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# needs dylib installed
	'macholib_tests/test_dyld.py::TestDyld::test_dyld_find'
	'macholib_tests/test_dyld.py::TestDyld::test_framework_find'
	'macholib_tests/test_dyld.py::TestTrivialDyld::testBasic'

	# try to use /bin/sh, but it can be another shell, depends on user configuration
	'macholib_tests/test_command_line.py::TestCmdLine::test_check_file'
	'macholib_tests/test_command_line.py::TestCmdLine::test_macho_dump'
	'macholib_tests/test_command_line.py::TestCmdLine::test_shared_main'
)
