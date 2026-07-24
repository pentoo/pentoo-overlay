# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Directory Services Internals Library"
HOMEPAGE="https://github.com/p0dalirius/pydsinternals"
SRC_URI="https://github.com/p0dalirius/pydsinternals/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}"/py"${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests unittest
