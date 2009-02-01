# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-sdk/nvidia-cuda-sdk-2.10.1215.2015.ebuild,v 1.1 2009/01/21 14:38:52 spock Exp $

inherit eutils

DESCRIPTION="NVIDIA CUDA Software Development Kit"
HOMEPAGE="http://developer.nvidia.com/cuda"

SRC_URI="http://developer.download.nvidia.com/compute/cuda/2_1/SDK/cuda-sdk-linux-${PV}-3233425.run"
LICENSE="CUDPP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug emulation livecd"

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
	rm -rf projects bin tools doc
	emake cuda-install=/opt/cuda ${myopts} || die
}

src_install() {
	cd "${S}/sdk"

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
}
