# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="A small Python module to parse various kinds of time expressions"
HOMEPAGE="https://pypi.python.org/pypi/pytimeparse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="MIT"
SLOT=0
IUSE=""
RDEPEND="${PYTHON_DEPS}"
