# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Radically simplified static file serving for WSGI applications"
HOMEPAGE="https://whitenoise.readthedocs.io/"
SRC_URI="https://github.com/evansd/whitenoise/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="brotli"

RDEPEND="
	brotli? ( app-arch/brotli[python,${PYTHON_USEDEP}] )
	dev-python/django[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/furo

python_test() {
	local EPYTEST_DESELECT=()
	if ! use brotli; then
		EPYTEST_DESELECT+=(
			'tests/test_django_whitenoise.py::test_get_brotli'
			'tests/test_storage.py::test_compressed_static_files_storage'
		)
	fi
	epytest
}
