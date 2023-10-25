# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Pure python3 for parsing Apple's crash reports"
HOMEPAGE="https://github.com/doronz88/pycrashreport"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
	>=dev-python/la_panic-0.4.9[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

src_prepare(){
	sed -i -e 's|==|>=|g' requirements.txt || die
	# https://github.com/doronz88/pycrashreport/issues/20
	sed -i -e 's|rpcclient|pycrashreport|g' pyproject.toml || die
	eapply_user
}
