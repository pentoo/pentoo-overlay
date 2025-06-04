# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pure python3 for parsing Apple's crash reports"
HOMEPAGE="https://github.com/doronz88/pycrashreport"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
	>=dev-python/la-panic-0.5.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

src_prepare(){
	sed -i -e 's|==|>=|g' requirements.txt || die
	eapply_user
}
