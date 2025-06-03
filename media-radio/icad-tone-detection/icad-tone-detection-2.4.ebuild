# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="library for extracting scanner radio tones from scanner audio"
HOMEPAGE="https://github.com/thegreatcodeholio/icad_tone_detection"

#SRC_URI="https://github.com/TheGreatCodeholio/icad_tone_detection/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

HASH_COMMIT="07201f9dc1ab096b371a12c8c5b4805091e3fd05"
SRC_URI="https://github.com/TheGreatCodeholio/icad_tone_detection/archive/${HASH_COMMIT}.tar.gz  -> ${P}.gh.tar.gz"

MY_PN="${PN//-/_}"
S="${WORKDIR}/${MY_PN}-${HASH_COMMIT}"

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
	sed -i 's/debug=True/debug=False/' src/icad_tone_detection/examples/detect_test.py || die
	distutils-r1_src_prepare
}

python_install() {
	distutils-r1_python_install
	python_newexe src/icad_tone_detection/examples/detect_test.py icad-tone-detection
}
