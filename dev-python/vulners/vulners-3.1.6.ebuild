# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python API wrapper for the Vulners Database"
HOMEPAGE="https://github.com/vulnersCom/api"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.10.18[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.4[${PYTHON_USEDEP}]
"
