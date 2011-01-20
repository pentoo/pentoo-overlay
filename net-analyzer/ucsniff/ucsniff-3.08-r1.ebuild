# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# most of the god-awful ugly stuff in here is due to ettercap
# workarounds and patches stolen from the ettercap ebuilds
WANT_AUTOMAKE="1.8"

EAPI="2"

inherit flag-o-matic eutils autotools libtool

DESCRIPTION="ip video sniffer"
HOMEPAGE="http://ucsniff.sourceforge.net"
SRC_URI="mirror://sourceforge/$PN/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+X +ffmpeg +x264 debug"
#IUSE="+vlc +X +ffmpeg +x264 debug"

DEPEND="X? ( x11-libs/libXext
			 media-libs/freetype )
		sys-libs/zlib
		net-libs/libpcap
		net-libs/libnet
		media-libs/alsa-lib"
#		vlc? ( media-video/vlc )"
RDEPEND="${DEPEND}"

pkg_setup() {
	append-flags "-DLTDL_SHLIB_EXT='\".so\"'"
}

src_prepare () {
	epatch "${FILESDIR}"/$PN-as-needed.patch
	epatch "${FILESDIR}"/$PN-rename-config.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable X gui) \
		$(use_enable vlc libvlc) \
		$(use_enable ffmpeg) \
		$(use_enable debug) \
		$(use_enable x264)
}

src_install() {
	DESTDIR="${D}" emake install
	rm -r "${D}"/usr/share/man/man8
	mv "${D}"/usr/share/man/man5/etter.conf.5 "${D}"/usr/share/man/man5/ucsniff.conf.5
}
