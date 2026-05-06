# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A python library for using the MISP Rest API"
HOMEPAGE="https://github.com/MISP/PyMISP"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=app-forensics/oletools-0.60.2[${PYTHON_USEDEP}]
	>=dev-python/deprecated-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/neo4j-6.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.9.0[${PYTHON_USEDEP}]
	>=dev-python/reportlab-4.4.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.33.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.6.3[brotli,${PYTHON_USEDEP}]
	>=dev-python/validators-0.35.0[${PYTHON_USEDEP}]
	>=dev-util/lief-0.17.6[python]
"

# missing packages to have more functionnalities.
# pure-magic-rs
# pydeep2
# beautifulsoup4
# pyfaup-rs
# extract_msg
# RTFDE

distutils_enable_sphinx "docs/source" dev-python/sphinx-autodoc-typehints dev-python/myst-parser
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	tests/test_emailobject.py
	tests/test_fileobject.py
)

EPYTEST_DESELECT=(
	tests/test_reportlab.py::TestPDFExport::test_utf
	tests/test_reportlab.py::TestPDFExport::test_utf_heavy
)
