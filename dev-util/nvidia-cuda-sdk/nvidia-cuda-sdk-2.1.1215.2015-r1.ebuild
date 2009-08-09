# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-sdk/nvidia-cuda-sdk-2.10.1215.2015.ebuild,v 1.1 2009/01/21 14:38:52 spock Exp $

inherit eutils

DESCRIPTION="NVIDIA CUDA Software Development Kit"
HOMEPAGE="http://developer.nvidia.com/cuda"

SRC_URI="http://developer.download.nvidia.com/compute/cuda/2_1/SDK/cuda-sdk-linux-2.10.1215.2015-3233425.run"
LICENSE="CUDPP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc emulation examples livecd"

RDEPEND=">=dev-util/nvidia-cuda-toolkit-2.1
	!livecd? ( >=x11-drivers/nvidia-drivers-180.22 )
	virtual/glut"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack_makeself
	cd "${S}"
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
	if use doc ; then
		dodoc doc
	else
		rm -rf doc
	fi
	if ! use examples ; then
		rm -rf projects bin tools
	fi
	emake lib/libcutil.so
	emake lib/libparamgl.so
	emake lib/librendercheckgl.so
	emake cuda-install=/opt/cuda ${myopts} || die
}

src_install() {
	cd "${S}/sdk"
	# don't use lib32 or lib64 directories
	unset ABI

	# Put libs inside sdk
	exeinto /opt/cuda/lib
	doexe "${S}"/sdk/lib/*
	rm -rf "${S}"/sdk/lib/*

	for f in $(find .); do
		local t="$(dirname ${f})"
		if [[ "${t/obj\/}" != "${t}" || "${t##*.}" == "a" ]]; then
			continue
		fi

		if [[ -x "${f}" && ! -d "${f}" ]]; then
			exeinto "/opt/cuda/sdk/$(dirname ${f})"
			doexe "${f}"
		else
			insinto "/opt/cuda/sdk/$(dirname ${f})"
			doins "${f}"
		fi
	done
	doenvd "${FILESDIR}/99cudasdk"
}
