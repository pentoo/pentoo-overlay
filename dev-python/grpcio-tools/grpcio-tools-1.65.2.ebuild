# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 multiprocessing prefix pypi

DESCRIPTION="Protobuf code generator for gRPC"
HOMEPAGE="https://grpc.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	~dev-python/grpcio-${PV}[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-5.26.1[${PYTHON_USEDEP}]
	<dev-python/protobuf-python-6[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/cython[${PYTHON_USEDEP}]
"

python_prepare_all() {
	distutils-r1_python_prepare_all
	hprefixify setup.py

	# use system protobuf
	sed -r -i \
		-e '/^CC_FILES=\[/,/\]/{/^CC_FILES=\[/n;/\]/!d;}' \
		-e '/^CC_INCLUDES=\[/,/\]/{/^CC_INCLUDES=\[/n;/\]/!d;}' \
		-e "s@^(PROTO_INCLUDE=')[^']+'@\1/usr/include'@" \
		-e '/^PROTOBUF_SUBMODULE_VERSION=/d' \
		protoc_lib_deps.py

	# fix the include path
	ln -s ../../../.. grpc_root
}

python_configure_all() {
	export GRPC_PYTHON_BUILD_WITH_CYTHON=1
	export GRPC_PYTHON_BUILD_EXT_COMPILER_JOBS="$(makeopts_jobs)"
}
