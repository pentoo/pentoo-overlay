# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="NVIDIA CUDA Software Development Kit"
HOMEPAGE="http://developer.nvidia.com/cuda"

CUDA_V=${PV//_/-}
DIR_V=${CUDA_V//./_}
DIR_V=${DIR_V//beta/Beta}

SRC_URI="http://developer.download.nvidia.com/compute/cuda/${DIR_V}/sdk/gpucomputingsdk_${CUDA_V}_linux.run"
LICENSE="CUDPP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc emulation examples opencl +cuda +pentoo"

RDEPEND=">=dev-util/nvidia-cuda-toolkit-3.0_beta1
	examples? ( !emulation? ( >=x11-drivers/nvidia-drivers-195.30 ) )
	media-libs/freeglut"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

RESTRICT="binchecks"

src_unpack() {
	unpack_makeself
}

src_prepare() {
	epatch "${FILESDIR}"/$PN-gcc44.patch
	sed -i -e 's:CUDA_INSTALL_PATH ?= .*:CUDA_INSTALL_PATH ?= /opt/cuda:' sdk/shared/common.mk sdk/C/common/common.mk || die "Failed to set path"
}

src_compile() {
        cd "${S}/sdk/C"
        emake lib/libcutil.so  || die
        emake lib/libparamgl.so  || die
        emake lib/librendercheckgl.so  || die
        emake shared/libshrutil.so || die

	if ! use examples; then
		return
	fi
	local myopts=""

	if use emulation; then
		myopts="emu=1"
	fi

	if use debug; then
		myopts="${myopts} dbg=1"
	fi

	cd "${S}/sdk"

	if use cuda; then
		cd C
		emake cuda-install=/opt/cuda ${myopts} || die
		cd ..
	fi

	if use opencl; then
		cd OpenCL
		emake || die
		cd ..
	fi
}

src_install() {
	cd "${S}/sdk"

	if ! use doc; then
		rm -rf doc ReleaseNotes.htm releaseNotesData
	fi

	if ! use examples; then
		rm -rf bin tools
	fi

	if ! use opencl; then
		rm -rf OpenCL
	fi

	for f in $(find .); do
		local t="$(dirname ${f})"
		if [[ "${t/obj\/}" != "${t}" || "${t##*.}" == "a" ]]; then
			continue
		fi

		if [[ -x "${f}" && ! -d "${f}" ]]; then
			exeinto "/opt/cuda/sdk/${t}"
			doexe "${f}"
		else
			insinto "/opt/cuda/sdk/${t}"
			doins "${f}"
		fi
	done
}
