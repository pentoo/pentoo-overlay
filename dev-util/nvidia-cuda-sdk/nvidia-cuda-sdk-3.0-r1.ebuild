# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-sdk/nvidia-cuda-sdk-3.0.ebuild,v 1.1 2010/03/21 13:52:56 spock Exp $

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
IUSE="debug +doc emulation +examples opencl +cuda"

RDEPEND=">=dev-util/nvidia-cuda-toolkit-3.0_beta1
	examples? ( !emulation? ( >=x11-drivers/nvidia-drivers-195.30 ) )
	virtual/glut"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

RESTRICT="binchecks"

src_unpack() {
	unpack_makeself
}

src_prepare() {
	epatch "${FILESDIR}"/$PN-gcc44.patch
}

src_compile() {
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
