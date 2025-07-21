# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="asyncio version of the standard multiprocessing module"
HOMEPAGE="https://github.com/omnilib/aiomultiprocess"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}"
