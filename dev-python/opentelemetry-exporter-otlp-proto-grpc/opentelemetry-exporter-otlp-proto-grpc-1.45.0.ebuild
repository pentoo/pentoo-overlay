# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="OpenTelemetry Collector Protobuf over gRPC Exporter"
HOMEPAGE="
	https://opentelemetry.io
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
# need special dependency to do test
RESTRICT="test"

RDEPEND="
	>=dev-python/googleapis-common-protos-1.57[${PYTHON_USEDEP}]
	<dev-python/grpcio-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/grpcio-1.75.1[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.15[${PYTHON_USEDEP}]
	=dev-python/opentelemetry-proto-1.45.0[${PYTHON_USEDEP}]
	~dev-python/opentelemetry-sdk-1.45.0[${PYTHON_USEDEP}]
	=dev-python/opentelemetry-exporter-otlp-proto-common-1.45.0[${PYTHON_USEDEP}]
	=dev-python/opentelemetry-exporter-otlp-common-0.66_beta0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
"
