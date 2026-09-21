# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Integrated RF Fingerprinting, Visual Flowgraph Editor, Model Hub and AI Orchestration Framework"
HOMEPAGE="https://github.com/black-210/VULTURE"
SRC_URI="https://github.com/black-210/VULTURE/archive/refs/heads/main.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/VULTURE-main"
LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="test"

RDEPEND="
	>=dev-python/numpy-1.21.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/scikit-learn-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/pyqt6-6.2.0[${PYTHON_USEDEP}]
	>=sci-ml/onnx-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/onnxruntime-bin-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.28.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-38.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-9.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	# setup.py uses wrong package name and doesn't find vulture in src/
	sed -i \
		-e "s|name='TERFALCOM'|name='vulture'|" \
		-e "s|packages=find_packages()|package_dir={'': 'src'}, packages=find_packages('src')|" \
		-e "s|python_requires='>=3.8',|python_requires='>=3.8', entry_points={'console_scripts': ['vulture=vulture.cli:cli', 'vulture-chemical-rf=vulture.chemical_rf.cli:chemical_rf_cli']},|" \
		setup.py || die
	# pyproject.toml has [project.scripts] but no [project.version], which
	# causes setuptools to fail; entry_points moved to setup.py above
	rm pyproject.toml || die
	eapply "${FILESDIR}/${P}-python314.patch"
	eapply_user
}
