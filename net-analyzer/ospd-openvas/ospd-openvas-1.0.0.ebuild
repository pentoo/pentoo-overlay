# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="OSP server implementation to allow GVM to remotely control an OpenVAS Scanner"
HOMEPAGE="https://www.greenbone.net/en/"
SRC_URI="https://github.com/greenbone/ospd-openvas/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=net-analyzer/ospd-2.0
	>=dev-python/redis-py-3.0.1[${PYTHON_USEDEP}]
	dev-python/psutil"

DEPEND="
	${RDEPEND}"

#python_compile() {
#	if use extras; then
#		bash "${S}"/doc/generate || die
#		HTML_DOCS=( "${S}"/doc/. )
#	fi
#	distutils-r1_python_compile
#}
