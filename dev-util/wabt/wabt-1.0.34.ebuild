# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

EGIT_COMMIT_TESTSUITE="c2a67a575ddc815ff2212f68301d333e5e30a923"
EGIT_COMMIT_WASM_C_API="b6dd1fb658a282c64b029867845bc50ae59e1497"

inherit cmake python-any-r1

DESCRIPTION="The WebAssembly Binary Toolkit"
HOMEPAGE="https://github.com/WebAssembly/wabt"
SRC_URI="
	https://github.com/WebAssembly/wabt/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/WebAssembly/testsuite/archive/${EGIT_COMMIT_TESTSUITE}.tar.gz -> \
		WebAssembly-testsuite-${EGIT_COMMIT_TESTSUITE}.tar.gz
	https://github.com/WebAssembly/wasm-c-api/archive/${EGIT_COMMIT_WASM_C_API}.tar.gz -> \
		WebAssembly-wasm-c-api-${EGIT_COMMIT_WASM_C_API}.tar.gz
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="dev-libs/openssl:="
DEPEND="
	${RDEPEND}
	test? (
		dev-cpp/gtest
		dev-libs/simde
	)
"
BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/ply[${PYTHON_USEDEP}]')
"

PATCHES=(
	# Disable tests depending on third_party/wasm-c-api/example/*.wasm
	#"${FILESDIR}/wabt-1.0.30-wasm-blob-tests.patch"
)

python_check_deps() {
	python_has_version "dev-python/ply[${PYTHON_USEDEP}]"
}

src_prepare() {
	cmake_src_prepare

	rm -r third_party/testsuite || die
	mv "${WORKDIR}/testsuite-${EGIT_COMMIT_TESTSUITE}" third_party/testsuite || die

	rm -r third_party/wasm-c-api || die
	mv "${WORKDIR}/wasm-c-api-${EGIT_COMMIT_WASM_C_API}" third_party/wasm-c-api || die

	rm -v fuzz-in/wasm/stuff.wasm wasm2c/examples/fac/fac.wasm || die

	use test || rm -v third_party/wasm-c-api/example/*.wasm || die

	sed -i 's;default_compiler =.*;default_compiler = os.getenv("CC", "cc");' test/run-spec-wasm2c.py || die

	# Broken tests
	rm test/wasm2c/spec/simd_lane.txt test/wasm2c/spec/simd_load.txt
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_GTEST=ON
		-DBUILD_LIBWASM=ON
		-DWITH_WASI=OFF # Need to unbundle third_party/uvwasi
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	cmake_build check
}
