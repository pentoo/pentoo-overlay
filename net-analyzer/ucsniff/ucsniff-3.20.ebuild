# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

# most of the god-awful ugly stuff in here is due to ettercap
# workarounds and patches stolen from the ettercap ebuilds
WANT_AUTOMAKE="1.11"

inherit flag-o-matic eutils autotools

DESCRIPTION="VoIP audio & video sniffer"
HOMEPAGE="http://ucsniff.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug plugins vlc X x264"

DEPEND="X? ( x11-libs/libXext
		media-libs/freetype )
	sys-libs/zlib
	net-libs/libpcap
	net-libs/libnet
	media-libs/alsa-lib
	vlc? ( media-video/vlc )
	media-video/libav
	x264? ( media-video/libav[x264] )"
RDEPEND="${DEPEND}"

src_prepare () {
	epatch "${FILESDIR}"/${PN}-as-needed.patch
	epatch "${FILESDIR}"/${P}-autoreconf.patch
	epatch "${FILESDIR}"/${PN}-mixed_types.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable X gui) \
		$(use_enable vlc libvlc) \
		$(use_enable debug) \
		$(use_enable plugins)
}

src_install() {
	DESTDIR="${D}" emake install || die
	rm -r "${D}"/usr/share/man/man8 || die
	mv "${D}"/usr/share/man/man5/etter.conf.5 "${D}"/usr/share/man/man5/ucsniff.conf.5 || die
}
