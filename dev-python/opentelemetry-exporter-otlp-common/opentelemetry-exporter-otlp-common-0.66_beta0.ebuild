# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="OpenTelemetry OTLP HTTP export utilities"
HOMEPAGE="
	https://pypi.org/project/opentelemetry-exporter-otlp-common/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	~dev-python/opentelemetry-sdk-1.45.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=(
	# missing dependency opentelemetry-exporter-http
	tests/test_http_client.py
)
distutils_enable_tests pytest
