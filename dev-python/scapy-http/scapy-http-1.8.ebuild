# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="HTTP-layer support for Scapy"
HOMEPAGE="https://github.com/invernizzi/scapy-http"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python-scapy[$PYTHON_USEDEP]"
RDEPEND="${DEPEND}"

#https://github.com/invernizzi/scapy-http/issues/25
my_install(){
	insinto $(python_get_sitedir)/scapy/layers
	doins scapy_http/http.py
}

src_install(){
	python_foreach_impl my_install
}
