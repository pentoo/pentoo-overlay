# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Identifies and fingerprints Web Application Firewall (WAF) products"
HOMEPAGE="https://github.com/sandrogauci/wafw00f"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/EnableSecurity/wafw00f/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/pluginbase-0.3[${PYTHON_USEDEP}]"
