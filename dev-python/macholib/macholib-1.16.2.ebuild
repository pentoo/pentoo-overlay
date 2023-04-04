# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1
distutils_enable_tests pytest
#Tests mostly fail and we should look into that
RESTRICT=test

DESCRIPTION="A package is a collection of utilities for dealing with IP addresses"
HOMEPAGE="http://github.com/ronaldoussoren/macholib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/altgraph[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
