# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8} )
inherit distutils-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND="=dev-python/nassl-3.0*[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.6[${PYTHON_USEDEP}]
	>=dev-python/tls_parser-1.2.2[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]' python3_7 )"

src_prepare(){
	rm -r tests
	sed -i "s|,<=2.9||g" setup.py
	eapply_user
}
