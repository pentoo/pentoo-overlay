# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PV="v2-${PV}"

PYTHON_COMPAT=( python{2_7,3_5} )
inherit distutils-r1

DESCRIPTION="OWASP ZAP Python API"
HOMEPAGE="https://github.com/zaproxy/zap-api-python"
SRC_URI="https://files.pythonhosted.org/packages/source/p/python-owasp-zap-v2/python-owasp-zap-${MY_PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-proxy/zaproxy"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/python-owasp-zap-${MY_PV}
