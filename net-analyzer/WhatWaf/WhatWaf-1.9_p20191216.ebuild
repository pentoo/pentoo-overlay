# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

HASH_COMMIT="625d6247f3f4f361339761bc231cd599c6b60767"

DESCRIPTION="Detect and bypass web application firewalls and protection systems"
HOMEPAGE="https://github.com/Ekultek/WhatWaf"
SRC_URI="https://github.com/Ekultek/WhatWaf/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

#https://github.com/Ekultek/WhatWaf/issues/628
#KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
