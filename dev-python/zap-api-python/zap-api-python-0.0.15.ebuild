# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="OWASP ZAP Python API"
HOMEPAGE="https://github.com/zaproxy/zap-api-python"
SRC_URI="https://github.com/zaproxy/zap-api-python/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-proxy/zaproxy"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
