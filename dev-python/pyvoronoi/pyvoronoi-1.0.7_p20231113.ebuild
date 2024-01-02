# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Cython wrapper for the Boost Voronoi library "
HOMEPAGE="https://github.com/Voxel8/pyvoronoi"
HASH_COMMIT="83d1aeb92787f630900c6378b33a36a191eddb97"
SRC_URI="https://github.com/Voxel8/pyvoronoi/archive/${HASH_COMMIT}/.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${HASH_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
