# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

BASE_V="$(ver_cut 0-3)"
# supports 11.x but URL has a specific version number
CUDA_MA="12"
CUDA_MI="0"
CUDA_V="${CUDA_MA}.${CUDA_MI}"

DESCRIPTION="NVIDIA Accelerated Deep Learning on GPU library"
HOMEPAGE="https://developer.nvidia.com/cudnn"
#SRC_URI="https://developer.download.nvidia.com/compute/redist/cudnn/v${BASE_V}/local_installers/${CUDA_V}/cudnn-linux-x86_64-${PV}_cuda${CUDA_MA}-archive.tar.xz"
SRC_URI="cudnn-linux-x86_64-8.8.0.121_cuda12-archive.tar.xz"

LICENSE="NVIDIA-cuDNN"
SLOT="0/8"
KEYWORDS="~amd64 ~amd64-linux"
RESTRICT="mirror fetch"

RDEPEND="=dev-util/nvidia-cuda-toolkit-12*"

QA_PREBUILT="/opt/cuda/targets/x86_64-linux/lib/*"

S="${WORKDIR}/cudnn-linux-x86_64-${PV}_cuda${CUDA_MA}-archive"

pkg_nofetch() {
	einfo "Please download ${A} from https://developer.nvidia.com/rdp/cudnn-download"
	einfo "The archive should then be placed into your DISTDIR directory."
}

src_install() {
	insinto /opt/cuda/targets/x86_64-linux
	doins -r include lib
}
