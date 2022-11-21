# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

#brach 22.04-dev
HASH_COMMIT="${PV}-dev"

DESCRIPTION="NVIDIA-maintained utilities to streamline mixed precision and distributed training in Pytorch"
HOMEPAGE="https://github.com/NVIDIA/apex"
SRC_URI="https://github.com/NVIDIA/apex/archive/${HASH_COMMIT}.tar.gz -> ${P}-gh.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="cuda"

RDEPEND=">=dev-python/tqdm-4.28.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.15.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/apex-${HASH_COMMIT}"

#If you wish to cross-compile for a single specific architecture,
#export TORCH_CUDA_ARCH_LIST="compute capability" before running setup.py.

python_compile() {
	if use cuda; then
		distutils-r1_python_compile --cpp_ext --cuda_ext
	fi
}

python_install() {
	if use cuda; then
		# disable gpu check
		# required for cross-compile and sanbox
		export TORCH_CUDA_ARCH_LIST="compute capability"
		distutils-r1_python_install --cpp_ext --cuda_ext
	fi
}


#FIXME:
#https://github.com/NVIDIA/apex/issues/161
# "No module named 'fused_layer_norm_cuda'"
