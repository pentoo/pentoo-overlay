# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_BUILD_TYPE="Release"
PYTHON_COMPAT=( python3_{6..9} )
PYTHON_REQ_USE="sqlite"

# NOTE: local built of LLVM is required because QBDI uses private APIs 
# not exported by gentoo regular LLVM installations 
LLVM_PV="7.0.0"
LLVM_P="llvm-${LLVM_PV}.src"
LLVM_TARGET="X86" # FIXME: only amd64 and x86 support in the current moment
LLVM_S="${WORKDIR}/${LLVM_P}"

inherit cmake eutils python-single-r1

DESCRIPTION="A Dynamic Binary Instrumentation framework based on LLVM"
HOMEPAGE="https://qbdi.quarkslab.com/"

SRC_URI="https://github.com/QBDI/QBDI/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://llvm.org/releases/${LLVM_PV}/${LLVM_P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86" # TODO: add ~arm support
IUSE="cpu_flags_x86_avx debug doc +tools"

BDEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

RDEPEND="
	sys-libs/zlib:0=
	tools? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/pybind11[${PYTHON_MULTI_USEDEP}]
			dev-python/pyyaml[${PYTHON_MULTI_USEDEP}]
		')
	)"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}_update_CMakeLists.patch"
	"${FILESDIR}/qbdi-0.7.0_fix_configs_validation_runner.patch"
)

S="${WORKDIR}/QBDI-${PV}"

_get_platform() {
	use amd64 && echo 'linux-X86_64'
	use x86 && echo 'linux-X86'
	#use arm && echo OwO
}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	cmake_src_prepare
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
	cmake_src_configure

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
	cmake_src_configure
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
		cmake_build -C "${LLVM_S}_build" $l
	done

	cmake_src_compile
}

src_install() {
	cmake_src_install

	if use tools; then
		insinto "/usr/share/${PN}"
		doins -r tools/validation_runner
		python_optimize "${D}"/usr/share/${PN}

		make_wrapper ValidationRunner \
			"${EPYTHON} /usr/share/${PN}/validation_runner/ValidationRunner.py"
	fi

	if use doc; then
		dodoc -r docker/* package/* examples # FIXME: install examples as docs instead building
		cmake_build docs-doxygen
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
