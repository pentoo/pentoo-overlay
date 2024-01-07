# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Easy to use python subprocess interface"
HOMEPAGE="https://github.com/ponty/easyprocess"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
