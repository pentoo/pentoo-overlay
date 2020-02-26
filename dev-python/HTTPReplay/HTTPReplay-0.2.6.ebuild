# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
#https://github.com/hatching/httpreplay/issues/19
#python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Properly interpret, decrypt, and replay pcap files"
HOMEPAGE="https://pypi.org/project/HTTPReplay/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#requires outdated net-proxy/mitmproxy, but we have python3 version only
RDEPEND=">=dev-python/dpkt-1.8.7[${PYTHON_USEDEP}]
	>=dev-python/tlslite-ng-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/click-6.6[${PYTHON_USEDEP}] <dev-python/click-7
	net-proxy/mitmproxy[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
