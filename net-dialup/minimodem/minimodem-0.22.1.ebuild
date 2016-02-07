# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools autotools-utils

DESCRIPTION="General-purpose software audio FSK modem."
HOMEPAGE="https://github.com/kamalmostafa/minimodem"
SRC_URI="https://github.com/kamalmostafa/minimodem/archive/${P}-1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="alsa pulseaudio sndfile"

DEPEND=""
RDEPEND="${RDEPEND}
	sci-libs/fftw:3.0
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )"

AUTOTOOLS_IN_SOURCE_BUILD=1

S="${WORKDIR}/${PN}-${P}-1"

src_prepare() {
	#apply upstream patch
	epatch "${FILESDIR}/${P}-ttytdd.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_with alsa ) \
		$(use_with pulseaudio ) \
		$(use_with sndfile )
}
