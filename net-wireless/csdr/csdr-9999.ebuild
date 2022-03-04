# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="a simple DSP library and cli for SDR"
HOMEPAGE="https://github.com/jketterl/csdr"
EGIT_REPO_URI="https://github.com/jketterl/csdr.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="media-libs/libsamplerate
		sci-libs/fftw:="
RDEPEND="${DEPEND}"
BDEPEND=""
