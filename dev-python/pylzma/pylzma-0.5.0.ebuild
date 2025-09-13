# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Platform independent python bindings for the LZMA compression library."
HOMEPAGE="https://www.joachim-bauch.de/projects/pylzma/"
SRC_URI="https://github.com/fancycode/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

src_prepare() {
	# temporary fixes, they should be removed when the upstream is corrected
	# https://github.com/fancycode/pylzma/pull/86
	sed -i -e 's/args/args, PyObject *kwargs/' src/pylzma/pylzma_decompress.h
	sed -i -e 's/EnvironmentError, e/EnvironmentError as e/' tests/test_usage.py
	eapply_user
}

python_compile() {
	# small trick to get it compile on recent Python versions
	# https://github.com/fancycode/pylzma/issues/80
	CFLAGS=-Wno-int-conversion distutils-r1_python_compile
}

python_install_all() {
	dodoc -r doc/.
	distutils-r1_python_install_all
}
