# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Directory Services Internals Library"
HOMEPAGE="https://github.com/p0dalirius/pydsinternals"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="test"

RDEPEND="dev-python/pyopenssl[${PYTHON_USEDEP}]"
RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare(){
	rm -r tests
	eapply_user
}
