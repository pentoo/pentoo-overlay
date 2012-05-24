# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-sdk/nvidia-cuda-sdk-4.1.ebuild,v 1.3 2012/02/05 16:39:02 spock Exp $

EAPI=2

inherit unpacker toolchain-funcs

DESCRIPTION="NVIDIA CUDA Software Development Kit"
HOMEPAGE="http://developer.nvidia.com/cuda"

CUDA_V=${PV//_/-}
DIR_V=${CUDA_V//./_}
DIR_V=${DIR_V//beta/Beta}

SRC_URI="http://developer.download.nvidia.com/compute/cuda/${DIR_V}/rel/sdk/gpucomputingsdk_${CUDA_V}.9_linux.run"
LICENSE="CUDPP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +doc +examples opencl pentoo +cuda"

RDEPEND=">=dev-util/nvidia-cuda-toolkit-${PV}
	examples? ( >=x11-drivers/nvidia-drivers-260.19.21 )
	media-libs/freeglut"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

RESTRICT="binchecks"

pkg_setup() {
	if use cuda || use opencl && [ $(gcc-major-version) -lt 4 -o $(gcc-minor-version) -lt 5 ]; then
		eerror "This package requires >=sys-devel/gcc-4.5 to build sucessfully."
		eerror "Please use gcc-config to switch to a compatible GCC version."
		die ">=sys-devel/gcc-4.4 required"
	fi
	echo $(gcc-major-version) $(gcc-minor-version)
}

src_compile() {
	if ! use examples && ! use pentoo ; then
		return
	fi
	local myopts=""

	if use debug; then
		myopts="${myopts} dbg=1"
	fi

	cd "${S}/sdk"

	if use cuda; then
		cd C
		emake -j1 cuda-install=/opt/cuda ${myopts} || die
		cd ..
	fi

	if use opencl; then
		cd OpenCL
		emake -j1 || die
		cd ..
	fi
}

src_install() {
	cd "${S}/sdk"

	if ! use doc; then
		rm -rf *.txt doc */doc */Samples.htm */releaseNotesData
	fi

	if ! use examples; then
		rm -rf bin */bin */tools
	fi

	for f in $(find .); do
		local t="$(dirname ${f})"
		if [[ "${t/obj\/}" != "${t}" || "${t##*.}" == "a" ]]; then
			continue
		fi

		if [[ ! -d "${f}" ]]; then
			if [[ -x "${f}" ]]; then
				exeinto "/opt/cuda/sdk/${t}"
				doexe "${f}"
			else
				insinto "/opt/cuda/sdk/${t}"
				doins "${f}"
			fi
		fi
	done
}
