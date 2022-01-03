# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Server Sent Events for Starlette"
HOMEPAGE="
	https://pypi.org/project/sse-starlette/
	https://github.com/sysid/sse-starlette
"
SRC_URI="https://github.com/sysid/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/starlette"
BDEPEND="
	test? (
		dev-python/pytest-asyncio
		dev-python/requests
	)
"

distutils_enable_tests pytest
