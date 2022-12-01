# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

#git branch
HASH_COMMIT="${PV}-dev"

DESCRIPTION="NVIDIA-maintained utilities to streamline mixed precision and distributed training in Pytorch"
HOMEPAGE="https://github.com/NVIDIA/apex"
SRC_URI="https://github.com/NVIDIA/apex/archive/${HASH_COMMIT}.tar.gz -> ${P}-gh.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

#FIXME: can't use global "cuda"
IUSE="cuda_ext"

RDEPEND=">=dev-python/cxxfilt-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.28.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.15.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-14.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

S="${WORKDIR}/apex-${HASH_COMMIT}"

#If you wish to cross-compile for a single specific architecture,
#export TORCH_CUDA_ARCH_LIST="compute capability" before running setup.py.
python_configure_all() {
	if use cuda_ext; then
#		export MAX_JOBS=1
		#export TORCH_CUDA_ARCH_LIST="compute capability"
		export TORCH_CUDA_ARCH_LIST="7.5"

		DISTUTILS_ARGS=( --cpp_ext --cuda_ext )
	fi
}

python_compile() {
	distutils-r1_python_compile -j1
}
