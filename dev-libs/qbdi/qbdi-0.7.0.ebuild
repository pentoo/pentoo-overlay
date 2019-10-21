# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_BUILD_TYPE="Release"
PYTHON_COMPAT=( python2_7 )

# NOTE: local built of LLVM is required because QBDI uses private APIs 
# not exported by gentoo regular LLVM installations 
LLVM_PV="7.0.0"
LLVM_P="llvm-${LLVM_PV}.src"
LLVM_TARGET="X86" # FIXME: only amd64 and x86 support in the current moment
LLVM_S="${WORKDIR}/${LLVM_P}"

inherit cmake-utils eutils python-r1

DESCRIPTION="A Dynamic Binary Instrumentation framework based on LLVM"
HOMEPAGE="https://qbdi.quarkslab.com/"

SRC_URI="https://github.com/QBDI/QBDI/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://llvm.org/releases/${LLVM_PV}/${LLVM_P}.tar.xz"

KEYWORDS="-* ~amd64 ~x86" # TODO: add ~arm support
LICENSE="Apache-2.0"
SLOT="0"
IUSE="cpu_flags_x86_avx debug doc +tools"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	sys-libs/ncurses:0=
	sys-libs/zlib:0="

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/QBDI-${PV}"

_get_platform() {
	use amd64 && echo linux-X86_64
	use x86 && echo linux-X86
	#use arm && echo OwO
}

pkg_setup() {
	if ! use cpu_flags_x86_avx; then
		ewarn "\nIf your cpu is support AVX and SSE innstruction"
		ewarn "enable it in make.conf before installing\n"
	fi

	python_setup
}

src_prepare() {
	eapply "${FILESDIR}/${P}_update_CMakeLists.patch"

	if use tools; then
		eapply "${FILESDIR}/${P}_fix_configs_validation_runner.patch"
		python_fix_shebang "${S}/tools/validation_runner"
	fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=( )

	# llvm minimal configuration
	mycmakeargs=(
		-DBUILD_SHARED_LIBS="FALSE"
		-DLLVM_DEFAULT_TARGET_TRIPLE="${CHOST}"
		-DLLVM_TARGETS_TO_BUILD="${LLVM_TARGET}"
		-DLLVM_BUILD_TOOLS="FALSE"
		-DLLVM_BUILD_UTILS="FALSE"
		-DLLVM_BUILD_TESTS="FALSE"
		-DLLVM_BUILD_EXAMPLES="FALSE"
		-DLLVM_INCLUDE_TOOLS="FALSE"
		-DLLVM_INCLUDE_UTILS="FALSE"
		-DLLVM_INCLUDE_TESTS="FALSE"
		-DLLVM_INCLUDE_EXAMPLES="FALSE"
		-DLLVM_BUILD_32_BITS=$(usex x86)
		-DCMAKE_C_FLAGS="${CFLAGS} -fvisibility=hidden"
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -fvisibility=hidden"
	)

	CMAKE_USE_DIR="${LLVM_S}"
	BUILD_DIR="${LLVM_S}_build"
	cmake-utils_src_configure

	# qbdi config
	mycmakeargs=(
		-DPLATFORM="$(_get_platform)"
		-DAS_BINARY="$(tc-getAS)"
		-DLLVM_BASE_DIR="${LLVM_S}"
		-DLLVM_STATIC_LIBS_DIR="${LLVM_S}_build/lib"
		-DCMAKE_CROSSCOMPILING="FALSE"
		-DTEST_QBDI="FALSE" # TODO: add tests support
		-DEXAMPLES="FALSE" # FIXME: i can't install examples because ld is falling
		-DLOG_DEBUG=$(usex debug)
		-DFULL_PACKAGE=$(usex tools)
		-DTOOLS_QBDIPRELOAD=$(usex tools)
		-DTOOLS_VALIDATOR=$(usex tools)
		-DTOOLS_FRIDAQBDI=$(usex tools)
		-DTOOLS_PYQBDI=$(usex tools)
		-DDEPENDENCY_SATISFIED="TRUE" # it's ok. Don't remove it
	)

	use cpu_flags_x86_avx || mycmakeargs+=( -DFORCE_DISABLE_AVX="TRUE" )

	CMAKE_USE_DIR="${S}"
	BUILD_DIR="${S}_build"
	cmake-utils_src_configure
}

src_compile() {
	local llvm_targets=(
		"LLVMSelectionDAG"
		"LLVMAsmPrinter"
		"LLVMBinaryFormat"
		"LLVMCodeGen"
		"LLVMScalarOpts"
		"LLVMProfileData"
		"LLVMInstCombine"
		"LLVMTransformUtils"
		"LLVMAnalysis"
		"LLVMTarget"
		"LLVMObject"
		"LLVMMCParser"
		"LLVMBitReader"
		"LLVMMCDisassembler"
		"LLVMMC"
		"LLVMCore"
		"LLVMSupport"
		"LLVMDemangle"
		"LLVM${LLVM_TARGET}Utils"
		"LLVM${LLVM_TARGET}Info"
		"LLVM${LLVM_TARGET}Disassembler"
		"LLVM${LLVM_TARGET}Desc"
		"LLVM${LLVM_TARGET}CodeGen"
		"LLVM${LLVM_TARGET}AsmPrinter"
		"LLVM${LLVM_TARGET}AsmParser"
	)

	for l in ${llvm_targets[@]}; do
		cmake-utils_src_make -C "${LLVM_S}_build" $l
	done

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	if use tools; then
		insinto "/usr/share/${PN}"
		doins -r tools/validation_runner
		python_optimize "${D}"/usr/share/${PN}

		make_wrapper ValidationRunner \
			"python2 /usr/share/${PN}/validation_runner/ValidationRunner.py"
	fi

	if use doc; then
		dodoc -r docker/* package/* examples # FIXME: install examples as docs instead building
		cmake-utils_src_make docs-doxygen
		for d in c cpp tools; do
			pushd "docs/doxygen_${d}" >/dev/null || die
			mv -v html ${PN}_${d} && dodoc -r ${PN}_${d} || die 'failed to install'
			popd >/dev/null || die
		done
	fi
}

pkg_postinst() {
	use doc && einfo "\nDocumentation and examples has been installed into /usr/share/doc/${P}/* directory\n"
	einfo "See more: https://qbdi.readthedocs.io/en/stable/\n"
}
