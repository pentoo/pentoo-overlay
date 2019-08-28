# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )

inherit distutils-r1

#HASH_COMMIT="${PV}"
HASH_COMMIT="0f6787062129b0d2270d4ea5de04e3aea57b3d79"

DESCRIPTION="Web application security scanner"
HOMEPAGE="https://github.com/shenril/Sitadel"
SRC_URI="https://github.com/shenril/Sitadel/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/Scrapy[${PYTHON_USEDEP}]"

S="${WORKDIR}/Sitadel-${HASH_COMMIT}"
