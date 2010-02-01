# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_PV=${PV/_/}

DESCRIPTION="Multiplatform IAX library for creating telephony solutions that interoperate with Asterisk"
HOMEPAGE="http://iaxclient.sourceforge.net/"
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
