# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="CMake converter for Visual Studio projects"
HOMEPAGE="https://github.com/pavelliavonau/cmakeconverter"
#SRC_URI="mirror://pypi/${P:0:1}/${MY_PN}/${P}.tar.gz"
SRC_URI="https://github.com/pavelliavonau/cmakeconverter/archive/v2.0.1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/cmakeconverter-${PV}"
