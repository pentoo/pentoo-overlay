# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION=" library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip
	https://github.com/lief-project/LIEF/releases/download/0.9.0/lief-0.9.0-py2.7-linux.egg
	https://github.com/lief-project/LIEF/releases/download/0.9.0/lief-0.9.0-py3.6-linux.egg
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
#dev-python/requests[${PYTHON_USEDEP}]
#	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/API-${PN}.com-${PV}"
