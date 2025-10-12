# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="CMake converter for Visual Studio projects"
HOMEPAGE="https://github.com/pavelliavonau/cmakeconverter"
SRC_URI="https://github.com/pavelliavonau/cmakeconverter/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/cmakeconverter-${PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
