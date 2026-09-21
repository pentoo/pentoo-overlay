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
			https://files.pythonhosted.org/packages/34/35/e7f862dbacbc99fadd9b14a614e49c99bf0f35fd9927a82f096e3de33531/onnxruntime-1.30.0-cp312-cp312-manylinux_2_28_x86_64.whl
		)
		python_targets_python3_13? (
			https://files.pythonhosted.org/packages/f1/a1/ede48ab5dc54907a2999362777f541e132639fb06628ded1932058aa8a36/onnxruntime-1.30.0-cp313-cp313-manylinux_2_28_x86_64.whl
		)
		python_targets_python3_14? (
			https://files.pythonhosted.org/packages/f1/38/8138eed225c5bc6ddfc05879ecac7dacc63c34b9b6f99be72839c1f6dc49/onnxruntime-1.30.0-cp314-cp314-manylinux_2_28_x86_64.whl
		)
	)
	arm64? (
		python_targets_python3_12? (
			https://files.pythonhosted.org/packages/16/bd/cbc5b8f91963689fdd622f463508c01d0aa95d3f944747b1e0b1eb2160b8/onnxruntime-1.30.0-cp312-cp312-manylinux_2_28_aarch64.whl
		)
		python_targets_python3_13? (
			https://files.pythonhosted.org/packages/89/06/e603c71f43f4fe3fd156a053af79cbed6e27a2c649f0988a67d97fedd39f/onnxruntime-1.30.0-cp313-cp313-manylinux_2_28_aarch64.whl
		)
		python_targets_python3_14? (
			https://files.pythonhosted.org/packages/c6/bc/1069e58b24779ba9d2fd479db5ecb3a15a6f49b585107c898819c0789558/onnxruntime-1.30.0-cp314-cp314-manylinux_2_28_aarch64.whl
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
