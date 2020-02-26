# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Nvidia GPU-based RAR bruteforcer"
HOMEPAGE="http://www.crark.net/"
SRC_URI="http://www.crark.net/Cuda-OpenSrc.rar"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-util/nvidia-cuda-sdk
	app-arch/unrar"

RDEPEND="x11-drivers/nvidia-drivers"

S="${WORKDIR}"

pkg_setup() {
	if [ -e "${ROOT}"/opt/cuda/sdk/common/common.mk ]; then
		export CUDAVERSION="2.2"
	elif [ -e "${ROOT}"/opt/cuda/sdk/C/common/common.mk ]; then
		export CUDAVERSION="2.3"
	elif [ -e "${ROOT}"/opt/cuda/sdk/C/shared/common.mk ]; then
		export CUDAVERSION="3.0"
	else
		die "Something failed to detect the CUDA SDK version properly"
	fi
}

src_prepare() {
	eapply "${FILESDIR}"/makefile-fixes.patch

	case ${CUDAVERSION} in
		2.2) epatch "${FILESDIR}"/cuda-sdk-2.2.patch ;;
		2.3) epatch "${FILESDIR}"/cuda-sdk-2.3.patch ;;
		3.0) epatch "${FILESDIR}"/cuda-sdk-3.0.patch ;;
		*)   die "Why is CUDAVERSION set to $CUDAVERSION?"
	esac

	default
}

src_install() {
	dobin bin/linux/release/cuda-rarcrypt
	dodoc readme
}
