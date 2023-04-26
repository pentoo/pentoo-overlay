# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python library for interacting with Censys Search Engine (censys.io)"
HOMEPAGE="https://github.com/censys/censys-python"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/requests-2.26.0[${PYTHON_USEDEP}]
	>=dev-python/backoff-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/rich-10.16.2[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
