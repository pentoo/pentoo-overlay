# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_PN="grpcio_testing"

inherit distutils-r1 pypi

DESCRIPTION="Testing utilities for gRPC Python"
HOMEPAGE="https://grpc.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

RDEPEND="
	~dev-python/grpcio-${PV}[${PYTHON_USEDEP}]
	>=dev-python/protobuf-6.30.0[${PYTHON_USEDEP}]
	<dev-python/protobuf-7[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"
