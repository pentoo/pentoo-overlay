# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Cross-platform inference accelerator for ONNX models"
HOMEPAGE="https://onnxruntime.ai https://github.com/microsoft/onnxruntime"

# Per-Python prebuilt wheels only (no sdist available on PyPI)
# pypi_wheel_url generates <pytag>/<letter>/<project>/ paths which 404 for onnxruntime;
# use direct hash-based CDN URLs instead.
SRC_URI="
	amd64? (
		python_targets_python3_12? (
			https://files.pythonhosted.org/packages/6c/44/1e9e762b95b7da0a8424913a1ed7c38cdaf88624a3c41ddba24ebac88bc9/onnxruntime-1.31.0-cp312-cp312-manylinux_2_28_x86_64.whl
		)
		python_targets_python3_13? (
			https://files.pythonhosted.org/packages/0d/ac/67ebbaab4b3083f2a6b27ee6c4aa400c7f8d6c72b5499aac7e4cd6ba74f5/onnxruntime-1.31.0-cp313-cp313-manylinux_2_28_x86_64.whl
		)
		python_targets_python3_14? (
			https://files.pythonhosted.org/packages/30/2e/5c6ec7e26a097e97ee70f2dee68b8ca4d9d26701f2f33c3f8ab585cb89fe/onnxruntime-1.31.0-cp314-cp314-manylinux_2_28_x86_64.whl
		)
	)
	arm64? (
		python_targets_python3_12? (
			https://files.pythonhosted.org/packages/53/1a/561b43ca1536d9e81d1785bb8a1a260a9e314ef6d04976ba0411c652bda1/onnxruntime-1.31.0-cp312-cp312-manylinux_2_28_aarch64.whl
		)
		python_targets_python3_13? (
			https://files.pythonhosted.org/packages/8a/d0/3677fe93ec0fa3c637744aa4c3ae6ef89a93ee229cd3c5157820f267c7bd/onnxruntime-1.31.0-cp313-cp313-manylinux_2_28_aarch64.whl
		)
		python_targets_python3_14? (
			https://files.pythonhosted.org/packages/37/fb/8be04665b700cb6e874d944e9932bb3c3969d3f53e820f5c42bfd26565d0/onnxruntime-1.31.0-cp314-cp314-manylinux_2_28_aarch64.whl
		)
	)
"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64"
RESTRICT="strip"

RDEPEND="
	>=dev-python/flatbuffers-23.5.26[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.21.6[${PYTHON_USEDEP}]
	>=dev-python/packaging-21[${PYTHON_USEDEP}]
	>=dev-python/protobuf-4.25.8[${PYTHON_USEDEP}]"
DEPEND="${PYTHON_DEPS}"

QA_PREBUILT="usr/lib/python*/site-packages/onnxruntime/capi/*.so
	usr/lib/python*/site-packages/onnxruntime/capi/libonnxruntime*.so.*"

python_compile() {
	local cpver="cp${EPYTHON/python/}"
	cpver="${cpver/./}"

	local abitag
	if use amd64; then
		abitag="manylinux_2_28_x86_64"
	elif use arm64; then
		abitag="manylinux_2_28_aarch64"
	fi

	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name onnxruntime ${PV} ${cpver} ${cpver}-${abitag})"
}
