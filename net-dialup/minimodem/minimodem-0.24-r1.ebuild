# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools
MY_P=${PN}-${PV}-1

DESCRIPTION="General-purpose software audio FSK modem."
HOMEPAGE="https://github.com/kamalmostafa/minimodem"
SRC_URI="https://github.com/kamalmostafa/minimodem/archive/${MY_P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_P}"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="alsa pulseaudio +sndfile"

DEPEND="sci-libs/fftw:3.0=
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-libs/libpulse )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	myeconfargs=(
		$(use_with alsa )
		$(use_with pulseaudio )
		$(use_with sndfile )
	)
	econf "${myeconfargs[@]}"
}
