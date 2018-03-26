# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
inherit distutils-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-python/nassl-1.1*[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/enum34[${PYTHON_USEDEP}]' python{2_7,3_3})
	$(python_gen_cond_dep 'dev-python/typing[${PYTHON_USEDEP}]' python{2_7,3_3,3_4})
"
