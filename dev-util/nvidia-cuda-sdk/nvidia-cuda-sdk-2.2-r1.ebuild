# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-sdk/nvidia-cuda-sdk-2.2-r1.ebuild,v 1.2 2009/07/18 21:09:03 spock Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="NVIDIA CUDA Software Development Kit"
HOMEPAGE="http://developer.nvidia.com/cuda"

CUDA_V=${PV//./_}

SRC_URI="http://developer.download.nvidia.com/compute/cuda/${CUDA_V}/sdk/cudasdk_${PV}_linux.run"
LICENSE="CUDPP"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug -doc emulation -examples"

RDEPEND=">=dev-util/nvidia-cuda-toolkit-2.2
	examples? ( !emulation? ( >=x11-drivers/nvidia-drivers-180.22 ) )
	virtual/glut"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

RESTRICT="binchecks"

pkg_setup() {
	if [ "$(gcc-major-version)" == "4" -a $(gcc-minor-version) -ge 4 ]; then
		eerror "This package requires <=sys-devel/gcc-4.3 to build sucessfully."
		eerror "Please use gcc-config to switch to a compatible GCC version."
		die "<=sys-devel/gcc-4.3 required"
	fi
}

src_unpack() {
	unpack_makeself
}

src_prepare() {
	sed -i -e 's:CUDA_INSTALL_PATH ?= .*:CUDA_INSTALL_PATH ?= /opt/cuda:' sdk/common/common.mk
}

src_compile() {
	local myopts=""

	if use emulation; then
		myopts="emu=1"
	fi

	if use debug; then
		myopts="${myopts} dbg=1"
	fi

	cd "${S}/sdk"
	emake lib/libcutil.so  || die
	emake lib/libparamgl.so  || die
	emake lib/librendercheckgl.so  || die

	if ! use examples; then
		return
	fi
	emake cuda-install=/opt/cuda ${myopts} || die
}

src_install() {
	cd "${S}/sdk"

	if ! use doc; then
		rm -rf doc ReleaseNotes.htm releaseNotesData
	fi

	if ! use examples; then
		rm -rf projects bin tools
	fi

	# Put libs inside sdk
	exeinto /opt/cuda/lib
	doexe "${S}"/sdk/lib/*  || die
	rm -rf "${S}"/sdk/lib/*

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
	doenvd "${FILESDIR}/99cudasdk"
}
