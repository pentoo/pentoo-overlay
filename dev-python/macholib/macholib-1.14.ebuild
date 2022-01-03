# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A package is a collection of utilities for dealing with IP addresses"
HOMEPAGE="https://bitbucket.org/ronaldoussoren/macholib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/altgraph[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
