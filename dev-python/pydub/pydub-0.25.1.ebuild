# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature

DESCRIPTION="Manipulate audio with an simple and easy high level interface"
HOMEPAGE="http://pydub.com/"
SRC_URI="https://github.com/jiaaro/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

BDEPEND="
	test? (
		media-video/ffmpeg[mp3,vorbis]
	)
	"

distutils_enable_tests unittest

python_test() {
	eunittest test/
}

pkg_postinst() {
	optfeature "opening and saving non-wav files - like mp3" media-video/ffmpeg
	#optfeature "playing audio" dev-python/simpleaudio # upstream suggests this, not available in gentoo or guru
	optfeature "playing audio" dev-python/pyaudio
}
