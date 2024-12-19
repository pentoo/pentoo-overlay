# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for parsing the opack format"
HOMEPAGE="https://pypi.org/project/opack2/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-python/arrow[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

#distutils_enable_tests pytest

#src_test(){
#	${EPYTHON} ./tests/test_opack.py || die
#}

#src_prepare(){
#	sed -i -e 's|pymobiledevice3|opack|g' pyproject.toml || die
#	eapply_user
#}
