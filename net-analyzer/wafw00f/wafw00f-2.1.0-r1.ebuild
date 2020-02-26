# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Identifies and fingerprints Web Application Firewall (WAF) products"
HOMEPAGE="https://github.com/sandrogauci/wafw00f"
SRC_URI="https://github.com/EnableSecurity/wafw00f/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/pluginbase-0.3[${PYTHON_USEDEP}]"
