# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Small library to parse TLS records."
HOMEPAGE="https://github.com/nabla-c0d3/tls_parser"
#SRC_URI="https://github.com/nabla-c0d3/tls_parser/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/typing
	dev-python/enum34
"

#typing; python_version < '3.5'
#enum34; python_version < '3.4'
