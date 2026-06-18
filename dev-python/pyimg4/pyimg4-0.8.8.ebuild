# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A Python library/CLI tool for parsing Apple's Image4 format"
HOMEPAGE="https://github.com/m1stadev/PyIMG4"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/asn1-2.7.0:2[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.7[${PYTHON_USEDEP}]
	>=dev-python/lzfse-0.4.2[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.18.0[${PYTHON_USEDEP}]
	dev-python/pylzss[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/remotezip-0.12.3[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
# it runs fine with the command pytest, but idle for some reasons with portage
EPYTEST_DESELECT=(
	'tests/test_im4p.py::test_read_lzss_dec'
	'tests/test_im4p.py::test_read_lzss_enc'
	'tests/test_im4p.py::test_read_lzfse_dec'
	'tests/test_im4p.py::test_read_lzfse_enc'
	'tests/test_im4p.py::test_read_payp'
)
distutils_enable_tests pytest
