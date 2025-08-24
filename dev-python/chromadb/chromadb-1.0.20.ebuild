# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Embedding database for LLM apps"
HOMEPAGE="https://pypi.org/project/chromadb/"

LICENSE="Apache-2.0"
SLOT="0"
#KEYWORDS="~amd64 ~arm64 ~x86"

#	>=dev-python/build-1.0.3[${PYTHON_USEDEP}]
# FIXME: WiP, add missing deps
RDEPEND="
	>=dev-python/pydantic-1.9[${PYTHON_USEDEP}]
	>=dev-python/pybase64-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.18.3[standard,${PYTHON_USEDEP}]
	>=dev-python/numpy-1.22.5[${PYTHON_USEDEP}]
	>=dev-python/posthog-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/typing_extensions-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/onnxruntime-1.14.1[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-exporter-otlp-proto-grpc-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-sdk-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/tokenizers-0.13.2[${PYTHON_USEDEP}]
	>=dev-python/pypika-0.48.9[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.65.0[${PYTHON_USEDEP}]
	>=dev-python/overrides-7.3.1[${PYTHON_USEDEP}]
	>=dev-python/grpcio-1.58.0[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/typer-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/kubernetes-28.1.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-8.2.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/mmh3-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.9.12[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27.0[${PYTHON_USEDEP}]
	>=dev-python/rich-10.11.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.19.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
