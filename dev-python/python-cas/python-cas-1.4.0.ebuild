# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Python CAS client library"
HOMEPAGE="https://github.com/python-cas/python-cas"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

#may be required by seafile
#git+git://github.com/haiwen/python-cas.git@ffc49235fd7cc32c4fdda5acfa3707e1405881df#egg=python_cas

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/lxml-3.4[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
