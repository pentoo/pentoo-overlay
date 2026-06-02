# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Concurrent appendable key-value storage"
HOMEPAGE="
	https://github.com/dask/partd
	https://pypi.org/project/partd/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/locket[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]
"
