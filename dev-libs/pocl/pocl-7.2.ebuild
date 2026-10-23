# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# 7.2's CUDA device doesn't support LLVM 23
LLVM_COMPAT=( {18..22} )
inherit cmake cuda llvm-r2

DESCRIPTION="Portable Computing Language (an implementation of OpenCL)"
HOMEPAGE="http://portablecl.org https://github.com/pocl/pocl"
SRC_URI="https://github.com/pocl/pocl/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
# TODO: hsa tce
IUSE="accel +conformance cuda debug examples +hwloc memmanager server spirv test"
RESTRICT="!test? ( test )"

# lld is automagic: without it the CPU device links kernels with the system linker
CLANG_DEPS="
	$(llvm_gen_dep '
		!cuda? (
			llvm-core/clang:${LLVM_SLOT}=
			llvm-core/llvm:${LLVM_SLOT}=
		)
		cuda? (
			llvm-core/clang:${LLVM_SLOT}=[llvm_targets_NVPTX]
			llvm-core/llvm:${LLVM_SLOT}=[llvm_targets_NVPTX]
		)
		llvm-core/lld:${LLVM_SLOT}=
		spirv? (
			dev-util/spirv-tools
			dev-util/spirv-llvm-translator:${LLVM_SLOT}=
		)
	')
"
RDEPEND="
	${CLANG_DEPS}
	virtual/opencl
	debug? ( dev-util/lttng-ust:= )
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	hwloc? ( sys-apps/hwloc:=[cuda?] )
"
DEPEND="
	${RDEPEND}
	dev-util/opencl-headers
"
BDEPEND="
	${CLANG_DEPS}
	virtual/pkgconfig
"

src_prepare() {
	use cuda && cuda_src_prepare
	cmake_src_prepare
}

src_configure() {
	local host_cpu_variants="generic"

	if use amd64 ; then
		# Use pocl's curated list of CPU variants which should contain a good match for any given amd64 CPU
		host_cpu_variants="distro"
	elif use ppc64 ; then
		# A selection of architectures in which new Altivec / VSX features were added
		# This attempts to recreate the amd64 "distro" option for ppc64
		# See discussion in bug #831859
		host_cpu_variants="pwr10;pwr9;pwr8;pwr7;pwr6;g5;a2;generic"
	elif use riscv; then
		host_cpu_variants="generic-rv64"
	fi

	local mycmakeargs=(
		-DENABLE_HSA=OFF

		-DENABLE_ICD=ON
		-DPOCL_ICD_ABSOLUTE_PATH=ON
		-DINSTALL_OPENCL_HEADERS=OFF

		# only appends -flto
		-DENABLE_IPO=OFF

		-DENABLE_POCL_BUILDING=ON
		-DKERNELLIB_HOST_CPU_VARIANTS="${host_cpu_variants}"

		-DENABLE_LLVM=ON
		-DSTATIC_LLVM=OFF
		-DWITH_LLVM_CONFIG=$(get_llvm_prefix -d)/bin/llvm-config

		-DENABLE_ALMAIF_DEVICE=$(usex accel)
		-DENABLE_CONFORMANCE=$(usex conformance)
		-DENABLE_CUDA=$(usex cuda)
		-DENABLE_HWLOC=$(usex hwloc)
		-DENABLE_LTTNG=$(usex debug)
		# Adds sanitizers(!) which aren't suitable for production
		-DHARDENING_ENABLE=OFF
		-DPOCL_DEBUG_MESSAGES=$(usex debug)
		-DUSE_POCL_MEMMANAGER=$(usex memmanager)
		-DENABLE_EXAMPLES=$(usex examples)
		-DENABLE_TESTS=$(usex test)
		-DENABLE_SPIRV=$(usex spirv)
		-DENABLE_REMOTE_CLIENT=1
		-DENABLE_REMOTE_SERVER=$(usex server)

		# automagic built-in kernels with -conformance
		-DCMAKE_DISABLE_FIND_PACKAGE_LIBJPEG_TURBO=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_OpenCV=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_onnxruntime=ON
	)

	cmake_src_configure
}

src_test() {
	local -x POCL_BUILDING=1
	local -x POCL_DEVICES=basic
	local -x CTEST_OUTPUT_ON_FAILURE=1
	local -x TEST_VERBOSE=1

	local CMAKE_SKIP_TESTS=(
		# These tests hang (or are very slow)
		regression/infinite_loop_cbs
		regression/passing_a_constant_array_as_an_arg_loopvec
		regression/infinite_loop_loopvec
		regression/passing_a_constant_array_as_an_arg_cbs

		# Failures
		kernel/test_halfs_loopvec
		kernel/test_halfs_cbs
		kernel/test_printf_vectors_halfn_loopvec
		kernel/test_printf_vectors_halfn_cbs
		workgroup/conditional_barrier_dynamic
		workgroup/ballot_loopvec
		workgroup/ballot_cbs
		regression/test_rematerialized_alloca_load_with_outside_pr_users
	)

	# https://github.com/pocl/pocl/blob/main/.github/workflows/build_linux.yml#L148
	# There are various CTest labels available, we may want to run just
	# a subset of those rather than having a large set where we're chasing
	# random failures from tinderboxing...
	cmake_src_test
}

src_install() {
	cmake_src_install

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${P}/examples
	fi
}
