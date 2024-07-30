# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
inherit distutils-r1

DESCRIPTION="High-performance RPC framework (python libraries)"
HOMEPAGE="https://grpc.io"
# same src as dev-pyhton/grpcio-tools
SRC_URI="https://github.com/grpc/grpc/archive/refs/tags/v${PV}.tar.gz -> grpc-${PV}.tar.gz"
S="${WORKDIR}/grpc-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="
	virtual/pkgconfig
	dev-python/cython[${PYTHON_USEDEP}]
"
RDEPEND="
	>=dev-libs/openssl-1.1.1:0=[-bindist(-)]
	>=dev-python/protobuf-python-5.26.1[${PYTHON_USEDEP}]
	>=dev-libs/re2-0.2024.07.02:=
	net-dns/c-ares:=
	sys-libs/zlib:=
"
DEPEND="
	${RDEPEND}
"

python_configure_all() {
	export GRPC_BUILD_WITH_BORING_SSL_ASM=0
	export GRPC_PYTHON_DISABLE_LIBC_COMPATIBILITY=1
	export GRPC_PYTHON_BUILD_SYSTEM_CARES=1
	export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
	export GRPC_PYTHON_BUILD_SYSTEM_RE2=1
	export GRPC_PYTHON_BUILD_SYSTEM_ABSL=1
	export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1
	export GRPC_PYTHON_BUILD_WITH_CYTHON=1
}
