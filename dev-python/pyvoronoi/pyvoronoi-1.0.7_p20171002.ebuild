# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
EGIT_OVERRIDE_COMMIT_VOXEL8_PYVORONOI="8ba7957141a3f39a90b48127bf971be76275faba"

inherit distutils-r1 git-r3

DESCRIPTION="Cython wrapper for the Boost Voronoi library "
HOMEPAGE="https://github.com/Voxel8/pyvoronoi"
EGIT_REPO_URI="https://github.com/Voxel8/pyvoronoi.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

RDEPEND=""
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
