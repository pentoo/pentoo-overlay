# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="HTTP-layer support for Scapy"
HOMEPAGE="https://github.com/invernizzi/scapy-http"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( net-analyzer/scapy[$PYTHON_USEDEP]
		$(python_gen_cond_dep 'dev-python/scapy-python3[${PYTHON_USEDEP}]' python3_{4,5,6})
	)"

#https://github.com/invernizzi/scapy-http/issues/25
my_install(){
	insinto $(python_get_sitedir)/scapy/layers
	doins scapy_http/http.py
}

src_install(){
	python_foreach_impl my_install
}
