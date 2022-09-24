# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="async parser for JET"
HOMEPAGE="https://github.com/skelsec/aesedb"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

#FIXME: no license
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""
RESTRICT="test"

RDEPEND=">=dev-python/unicrypto-0.0.5[${PYTHON_USEDEP}]
	>=dev-python/aiowinreg-0.0.7[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	rm -r tests
	eapply_user
}
