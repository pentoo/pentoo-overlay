# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/log2timeline/dfdatetime

inherit distutils-r1 pypi

DESCRIPTION="Digital Forensics date and time"
HOMEPAGE="https://github.com/log2timeline/dfdatetime"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	epytest tests/* || die "Tests failed with ${EPYTHON}"
}
