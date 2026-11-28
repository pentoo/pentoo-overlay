# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Capped at the newest slot that media-libs/mesa, dev-libs/rocm-comgr,
# dev-util/intel-graphics-compiler and dev-libs/pocl all support, so that is
# the default; raise it when they all support a newer one. The blockers keep
# every LLVM user in an OpenCL/OpenGL process on the chosen slot: two LLVMs in
# one process crash.
LLVM_COMPAT=( {20..22} )
LLVM_OPTIONAL=1
inherit llvm-r2

DESCRIPTION="Virtual for pulling in appropriate opencl stuffs"
HOMEPAGE="https://pentoo.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="opencl-cpu video_cards_amdgpu video_cards_intel video_cards_i915 video_cards_i965 video_cards_nvidia"
REQUIRED_USE="${LLVM_REQUIRED_USE} || ( opencl-cpu video_cards_amdgpu video_cards_nvidia )"

# dev-util/opencl-headers is a system-wide workaround: some ebuilds build
# against OpenCL but only depend on virtual/opencl, which doesn't bring the
# headers. Keeping them installed lets those ebuilds build.
RDEPEND="virtual/opencl
		dev-util/clinfo
		dev-util/opencl-headers
		opencl-cpu? ( amd64? ( || ( dev-libs/pocl dev-util/intel-ocl-sdk ) ) )
		video_cards_amdgpu? (
			dev-libs/rocm-opencl-runtime
			dev-util/rocminfo
			sys-apps/amdgpu_top
		)
		elibc_glibc? (
			video_cards_intel? ( dev-libs/intel-compute-runtime )
			video_cards_i915? ( dev-libs/intel-compute-runtime )
			video_cards_i965? ( dev-libs/intel-compute-runtime )
		)
		video_cards_nvidia? ( x11-drivers/nvidia-drivers )
		$(llvm_gen_dep '
			!dev-libs/pocl[-llvm_slot_${LLVM_SLOT}(-)]
			!dev-libs/rocm-comgr[-llvm_slot_${LLVM_SLOT}(-)]
			!dev-util/intel-graphics-compiler[-llvm_slot_${LLVM_SLOT}(-)]
			!media-libs/mesa[llvm,-llvm_slot_${LLVM_SLOT}(-)]
		')
		"

pkg_setup() {
	if use opencl-cpu && ! use amd64; then
		die "opencl-cpu is only available for 64 bit systems"
	fi
}
