# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

DESCRIPTION="Digital Speech Decoder"
HOMEPAGE="https://github.com/LouisErigHerve/dsd.git"
LICENSE="bsd"
SLOT="0"
IUSE="test"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/LouisErigHerve/dsd.git"
	inherit git-r3

else
	COMMIT="f175834e45a1a190171dff4597165b27d6b0157b"
	SRC_URI="https://github.com/szechyjs/dsd/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
	KEYWORDS="~amd64 ~x86"
fi


DEPEND="
	>=media-libs/mbelib-1.3.0-r1
	media-libs/portaudio
	>=sci-libs/itpp-4.3.1
	media-libs/libsndfile
	sci-libs/fftw:3.0
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DDISABLE_TEST="$(usex test OFF ON)"
	)
	cmake-utils_src_configure
}
