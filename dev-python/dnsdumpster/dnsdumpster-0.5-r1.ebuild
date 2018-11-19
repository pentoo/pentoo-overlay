# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Python API for dnsdumpster.com"
HOMEPAGE="https://github.com/PaulSec/API-dnsdumpster.com"
SRC_URI="https://github.com/PaulSec/API-dnsdumpster.com/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/API-${PN}.com-${PV}"
