# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="A rate limiting extension for Starlette and Fastapi"
HOMEPAGE="https://github.com/laurents/slowapi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test +redis"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/limits-2.3[${PYTHON_USEDEP}]
	redis? ( >=dev-python/redis-3.4.1[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
