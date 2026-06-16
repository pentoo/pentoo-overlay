# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

# This is the commit that the CI for the release commit used
BINS_COMMIT="71482f7194847b4ece45a9e53f28085b6bab40a4"
GITHUB_REPOSITORY="rizinorg/rizin"
GITHUB_COMMIT="9e7cc02fcff93b5e8bb1388b3635ecb84752accc"

inherit meson python-any-r1 github-snapshot

DESCRIPTION="reverse engineering framework for binary analysis"
HOMEPAGE="https://rizin.re/"

LIBDEMANGLE_COMMIT="e633061e901208a20ed90f8aaf0b64f25caf73eb"
BLAKE2_COMMIT="ed1974ea83433eba7b2d95c5dcd9ac33cb847913"
RIZIN_GRAMMAR_COMMIT="815845762d59f727d79e7aa6f810688b2e1e35d2"
SOFTFLOAT_COMMIT="537d18e71a51aea70f6b54334854f7014c6458c7"

SRC_URI+=" https://github.com/rizinorg/rz-libdemangle/archive/${LIBDEMANGLE_COMMIT}.tar.gz -> rz-libdemangle-${LIBDEMANGLE_COMMIT}.tar.gz
    https://github.com/BLAKE2/BLAKE2/archive/${BLAKE2_COMMIT}.tar.gz -> BLACK2-${BLAKE2_COMMIT}.tar.gz
    https://github.com/rizinorg/rizin-grammar-c/archive/${RIZIN_GRAMMAR_COMMIT}.tar.gz -> rizin-grammar-c-${RIZIN_GRAMMAR_COMMIT}.tar.gz
    https://github.com/rizinorg/softfloat/archive/${SOFTFLOAT_COMMIT}.tar.gz -> softfloat-${SOFTFLOAT_COMMIT}.tar.gz
    test? ( https://github.com/rizinorg/rizin-testbins/archive/${BINS_COMMIT}.tar.gz -> rizin-testbins-${BINS_COMMIT}.tar.gz )
"

LICENSE="Apache-2.0 BSD LGPL-3 MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="test"

# Need to audit licenses of the binaries used for testing
RESTRICT="test? ( fetch ) !test? ( test )"

RDEPEND="
	app-arch/lz4:0=
	app-arch/xz-utils
	app-arch/zstd:=
	dev-libs/blake3:=
	>=dev-libs/capstone-5:0=
	dev-libs/libmspack
	dev-libs/libzip:0=
	dev-libs/openssl:0=
	dev-libs/libpcre2:0=[jit]
	>=dev-libs/tree-sitter-0.19.0:=
	dev-libs/xxhash
	sys-apps/file
	virtual/zlib:=
	dev-libs/zydis
"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

PATCHES=(
	"${FILESDIR}/${PN}-0.4.0-never-rebuild-parser.patch"
#	"${FILESDIR}/${PN}-0.8.2-capstone6-sparc.patch"
)

src_prepare() {
	default

	mv "${WORKDIR}/rz-libdemangle-${LIBDEMANGLE_COMMIT}" subprojects/libdemangle || die
	mv "${WORKDIR}/BLAKE2-${BLAKE2_COMMIT}" subprojects/blake2 || die
	mv subprojects/packagefiles/blake2/meson.build subprojects/blake2 || die
	mv "${WORKDIR}/rizin-grammar-c-${RIZIN_GRAMMAR_COMMIT}" subprojects/rizin-grammar-c || die
	mv subprojects/packagefiles/rizin-grammar-c/meson.build subprojects/rizin-grammar-c || die
	mv "${WORKDIR}/softfloat-${SOFTFLOAT_COMMIT}" subprojects/softfloat || die

	local py_to_mangle=(
		librz/core/cmd_descs/cmd_descs_generate.py
		sys/clang-format.py
		test/fuzz/scripts/fuzz_rz_asm.py
		test/scripts/gdbserver.py
	)

	python_fix_shebang "${py_to_mangle[@]}"

	# https://github.com/rizinorg/rizin/issues/3459
	sed -ie '/dyld_chained_ptr_arm64e_auth/d' test/unit/test_bin_mach0.c || die

	if use test; then
		cp -r "${WORKDIR}/rizin-testbins-${BINS_COMMIT}" "${S}/test/bins" || die
		cp -r "${WORKDIR}/rizin-testbins-${BINS_COMMIT}" "${S}" || die
	fi
}

src_configure() {
	local emesonargs=(
		-Dcli=enabled
		-Duse_sys_blake3=enabled
		-Duse_sys_capstone=enabled
		-Duse_sys_libmspack=enabled
		-Duse_sys_libzip=enabled
		-Duse_sys_libzstd=enabled
		-Duse_sys_lz4=enabled
		-Duse_sys_lzma=enabled
		-Duse_sys_magic=enabled
		-Duse_sys_openssl=enabled
		-Duse_sys_pcre2=enabled
		-Duse_sys_tree_sitter=enabled
		-Duse_sys_xxhash=enabled
		-Duse_sys_zlib=enabled
		-Duse_sys_zydis=enabled

		$(meson_use test enable_tests)
		$(meson_use test enable_rz_test)
	)
	meson_src_configure
}

src_test() {
	# We can select running either unit or integration tests, or all of
	# them by not passing --suite. According to upstream, integration
	# tests are more fragile and unit tests are sufficient for testing
	# packaging, so only run those.
	meson_src_test --suite unit
}
