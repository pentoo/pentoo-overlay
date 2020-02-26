# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Capture, repeat and live intercept HTTP requests"
HOMEPAGE="https://github.com/MobSF/httptools"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#'mitmproxy==5.0.1'
RDEPEND="net-proxy/mitmproxy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	sed -i "s|mitmproxy==5.0.1|mitmproxy|g" setup.py
	eapply_user
}
