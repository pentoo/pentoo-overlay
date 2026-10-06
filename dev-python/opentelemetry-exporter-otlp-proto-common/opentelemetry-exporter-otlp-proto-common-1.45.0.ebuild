# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="OpenTelemetry Protobuf encoding"
HOMEPAGE="
	https://opentelemetry.io/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
# need special dependency to do test
RESTRICT="test"

RDEPEND="
	>=dev-python/opentelemetry-proto-1.45.0[${PYTHON_USEDEP}]
"
