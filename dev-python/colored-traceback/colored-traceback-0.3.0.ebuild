# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Automatically color Python's uncaught exception tracebacks"
HOMEPAGE="https://github.com/staticshock/colored-traceback.py"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#https://github.com/staticshock/colored-traceback.py/issues/18
