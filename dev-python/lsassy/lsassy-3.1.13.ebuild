# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to parse remote lsass dumps"
HOMEPAGE="https://github.com/Hackndo/lsassy/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=">=dev-python/netaddr-0.8.0[${PYTHON_USEDEP}]
	>=app-exploits/pypykatz-0.6.3[${PYTHON_USEDEP}]
	>=dev-python/impacket-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/rich-10.6.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare(){
	rm -r tests
	eapply_user
}
