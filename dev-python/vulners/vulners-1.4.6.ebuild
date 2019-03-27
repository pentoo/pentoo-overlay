# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="Python API wrapper for the Vulners Database"
HOMEPAGE="https://github.com/vulnersCom/api"
SRC_URI="https://github.com/vulnersCom/api/archive/${PV}-Release.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

S="${WORKDIR}/api-${PV}-Release"

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
