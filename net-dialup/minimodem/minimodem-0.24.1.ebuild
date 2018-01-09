# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools versionator

MY_P="${PN}-$(replace_version_separator 2 '-')"

DESCRIPTION="General-purpose software audio FSK modem."
HOMEPAGE="https://github.com/kamalmostafa/minimodem"
SRC_URI="https://github.com/kamalmostafa/minimodem/archive/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-3+"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="alsa pulseaudio +sndfile"

DEPEND="sci-libs/fftw:3.0
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_P}"

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
