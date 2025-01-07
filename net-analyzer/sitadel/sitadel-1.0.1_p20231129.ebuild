# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

#HASH_COMMIT="${PV}"
HASH_COMMIT="e4d9ed4b4f1ff177c89aa7e56412e4eab9edff1f"

DESCRIPTION="Web application security scanner"
HOMEPAGE="https://github.com/shenril/Sitadel"
SRC_URI="https://github.com/shenril/Sitadel/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
# https://github.com/shenril/Sitadel/issues/48
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/Scrapy[${PYTHON_USEDEP}]"

S="${WORKDIR}/Sitadel-${HASH_COMMIT}"
