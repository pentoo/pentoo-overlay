# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="library for extracting scanner radio tones from scanner audio"
HOMEPAGE="https://github.com/thegreatcodeholio/icad_tone_detection"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pydub[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	media-video/ffmpeg"

src_prepare() {
	sed -i 's/src.//' detect_test.py || die
	distutils-r1_src_prepare
}

python_install() {
	distutils-r1_python_install
	python_newexe detect_test.py icad-tone-detection
}
