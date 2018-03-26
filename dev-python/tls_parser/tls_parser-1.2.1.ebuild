# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Small library to parse TLS records."
HOMEPAGE="https://github.com/nabla-c0d3/tls_parser"
SRC_URI="https://github.com/nabla-c0d3/tls_parser/archive/${PV}.tar.gz -> ${P}.tar.gz"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/enum34[${PYTHON_USEDEP}]' python{2_7,3_3})
	$(python_gen_cond_dep 'dev-python/typing[${PYTHON_USEDEP}]' python{2_7,3_3,3_4})
"
