# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_IN_SOURCE_BUILD=1
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

RDEPEND=">=dev-python/tqdm-4.28.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.15.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

S="${WORKDIR}/apex-${HASH_COMMIT}"

#python_prepare() {
#	if use !cuda_ext; then
#		einfo "CUDA disabled"
		#sed -i -e "s|fused_layer_norm_cuda = importlib|\#fused_layer_norm_cuda = importlib|" apex/normalization/fused_layer_norm.py || die
#		eapply ${FILESDIR}/disable_cuda.patch
#	fi
#	eapply_user
#}

#python_prepare_all() {
#	export TORCH_CUDA_ARCH_LIST="compute capability"
#	python_setup
#	esetup.py
#	distutils-r1_python_prepare_all
#}

#If you wish to cross-compile for a single specific architecture,
#export TORCH_CUDA_ARCH_LIST="compute capability" before running setup.py.
python_configure_all() {
#	export MAX_JOBS=1
	if use cuda_ext; then
#		export TORCH_CUDA_ARCH_LIST="compute capability"
		addpredict "/dev/nvidiactl"
		DISTUTILS_ARGS=( --cpp_ext --cuda_ext )
	fi
}

#python_compile_all() {
#	export TORCH_CUDA_ARCH_LIST="compute capability"
#	esetup.py
#}

#python_compile() {
#	export TORCH_CUDA_ARCH_LIST="compute capability"
	# breaks with parallel build
	# need to avoid dropping .so plugins into
	# build-lib, which breaks tests
#	esetup.py build_ext --inplace
	# --cpp_ext --cuda_ext build_ext --inplace -j1
#	TORCH_CUDA_ARCH_LIST="compute capability" distutils-r1_python_compile -j1
#	distutils-r1_python_compile -j1
#}
