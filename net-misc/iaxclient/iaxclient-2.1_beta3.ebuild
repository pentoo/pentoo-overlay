# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI="2"

DESCRIPTION="Multiplatform IAX library for creating telephony solutions that interoperate with Asterisk"
HOMEPAGE="http://iaxclient.sourceforge.net/"
MY_PV=${PV/_/}
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="media-libs/portaudio
		 media-sound/gsm
		 media-video/ffmpeg[speex]"

S="${WORKDIR}"/"${PN}"-"${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}"/iaxclient-fix-avcodec-include.patch || die "patch failed"
}
src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}

